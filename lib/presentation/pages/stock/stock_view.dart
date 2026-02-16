import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_test/core/extensions/number_format_extension.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/hooks/use_tab_scroll_controller.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_page.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:provider/provider.dart';

class StockView extends StatefulWidget {
  const StockView({super.key, required this.tabScrollController});

  final TabScrollController tabScrollController;

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  StockProvider? _provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<StockProvider>();
    if (_provider != provider) {
      _provider?.removeListener(_showAlertSnackBar);
      _provider = provider;
      provider.addListener(_showAlertSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<StockProvider, ({bool hasError, bool isLoading})>(
      selector: (_, p) =>
          (hasError: p.state.hasError, isLoading: p.state.isLoading),
      builder: (context, state, _) {
        if (state.hasError) {
          return const Scaffold(
            body: Center(child: Text('종목 정보를 불러오지 못했습니다.')),
          );
        }
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: StockAppBarView(
            tabController: widget.tabScrollController.tabController,
            onTabTap: widget.tabScrollController.scrollTo,
          ),
          body: ListView(
            key: widget.tabScrollController.viewportKey,
            controller: widget.tabScrollController.scrollController,
            children: [
              StockPriceView(key: widget.tabScrollController.keys[0]),
              const Divider(),
              StockSummaryView(key: widget.tabScrollController.keys[1]),
              const Divider(),
              StockInputView(key: widget.tabScrollController.keys[2]),
              const Divider(),
              StockExpansionView(key: widget.tabScrollController.keys[3]),
              const Divider(),
              StockEtcView(key: widget.tabScrollController.keys[4]),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _provider?.removeListener(_showAlertSnackBar);
    super.dispose();
  }

  void _showAlertSnackBar() {
    final alert = _provider?.state.triggeredAlert;
    if (alert == null) return;
    _provider?.clearAlert();
    final direction = alert.isUpper ? '상한 돌파' : '하한 돌파';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              '${alert.item.stockCode} 목표가 ${alert.item.targetPrice}원 $direction',
            ),
          ),
        );
    });
  }
}

class StockAppBarView extends StatelessWidget implements PreferredSizeWidget {
  const StockAppBarView({
    super.key,
    required this.tabController,
    required this.onTabTap,
  });

  final TabController tabController;
  final ValueChanged<int> onTabTap;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Selector<StockProvider, ({String name, String code, String logoUrl})>(
            selector: (_, p) => (
              name: p.state.stockOrDefault.name,
              code: p.state.stockOrDefault.code,
              logoUrl: p.state.stockOrDefault.logoUrl,
            ),
            builder: (context, stock, _) => Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                  foregroundImage: stock.logoUrl.isNotEmpty
                      ? NetworkImage(stock.logoUrl)
                      : null,
                  onForegroundImageError: stock.logoUrl.isNotEmpty
                      ? (_, _) {}
                      : null,
                  child: Text(
                    stock.name.isNotEmpty ? stock.name[0] : '',
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stock.code,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
      actions: [
        Selector<StockProvider, ({bool isInWatchlist, String code})>(
          selector: (_, p) => (
            isInWatchlist: p.state.isInWatchlist,
            code: p.state.stockOrDefault.code,
          ),
          builder: (context, data, _) => IconButton(
            icon: Icon(
              data.isInWatchlist ? Icons.favorite : Icons.favorite_border,
              color: data.isInWatchlist ? Colors.red : null,
            ),
            onPressed: () async {
              final provider = context.read<StockProvider>();
              final needsDialog = await provider.onFavoriteToggled(data.code);
              if (!needsDialog || !context.mounted) return;
              final result =
                  await showDialog<({int targetPrice, AlertType alertType})>(
                    context: context,
                    builder: (_) => const _WatchlistDialog(),
                  );
              if (result == null) return;
              await provider.onWatchlistAdded(
                stockCode: data.code,
                targetPrice: result.targetPrice,
                alertType: result.alertType,
              );
            },
          ),
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: StockPage.tabViewTitles.map((title) => Tab(text: title)).toList(),
        onTap: onTabTap,
      ),
    );
  }
}

class StockPriceView extends StatelessWidget {
  const StockPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      StockProvider,
      ({int currentPrice, double changeRate, List<int> priceHistory})
    >(
      selector: (_, p) => (
        currentPrice: p.state.stockOrDefault.currentPrice,
        changeRate: p.state.stockOrDefault.changeRate,
        priceHistory: p.state.stockOrDefault.priceHistory,
      ),
      builder: (context, stock, _) {
        final spots = stock.priceHistory
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
            .toList();
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('가격', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    stock.currentPrice.formattedPrice,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '원',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    stock.changeRate.formattedChangeRate,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: _changeRateColor(stock.changeRate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: _changeRateColor(stock.changeRate),
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: _changeRateColor(
                            stock.changeRate,
                          ).withAlpha(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _changeRateColor(double rate) {
    if (rate > 0) return Colors.red;
    if (rate < 0) return Colors.blue;
    return Colors.grey;
  }
}

class StockSummaryView extends StatelessWidget {
  const StockSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('요약', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const StockSummaryInfoView(label: '시가총액', value: '432조 원'),
          const StockSummaryInfoView(label: 'PER', value: '12.5'),
          const StockSummaryInfoView(label: 'PBR', value: '1.3'),
          const StockSummaryInfoView(label: '52주 최고', value: '78,000원'),
          const StockSummaryInfoView(label: '52주 최저', value: '59,000원'),
        ],
      ),
    );
  }
}

class StockSummaryInfoView extends StatelessWidget {
  const StockSummaryInfoView({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class StockInputView extends StatelessWidget {
  const StockInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('입력', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: '목표가',
              hintText: '목표 가격을 입력하세요',
              border: OutlineInputBorder(),
              suffixText: '원',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: '메모',
              hintText: '메모를 입력하세요',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class StockExpansionView extends StatelessWidget {
  const StockExpansionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('확장 패널', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const ExpansionTile(
            title: Text('기업 정보'),
            children: [
              ListTile(title: Text('업종: 전자부품')),
              ListTile(title: Text('상장일: 1975-06-11')),
              ListTile(title: Text('대표이사: 한종희')),
            ],
          ),
          const ExpansionTile(
            title: Text('재무 정보'),
            children: [
              ListTile(title: Text('매출액: 258조 원')),
              ListTile(title: Text('영업이익: 6.5조 원')),
              ListTile(title: Text('순이익: 15.8조 원')),
            ],
          ),
          const ExpansionTile(
            title: Text('배당 정보'),
            children: [
              ListTile(title: Text('배당금: 1,444원')),
              ListTile(title: Text('배당수익률: 2.0%')),
            ],
          ),
        ],
      ),
    );
  }
}

class StockEtcView extends StatelessWidget {
  const StockEtcView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('기타', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('알림 설정'),
            subtitle: Text('목표가 도달 시 알림'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.share_outlined),
            title: Text('공유하기'),
            subtitle: Text('종목 정보 공유'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('투자 유의사항'),
            subtitle: Text('투자 시 참고사항을 확인하세요'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

class _WatchlistDialog extends StatefulWidget {
  const _WatchlistDialog();

  @override
  State<_WatchlistDialog> createState() => _WatchlistDialogState();
}

class _WatchlistDialogState extends State<_WatchlistDialog> {
  final _priceController = TextEditingController();
  AlertType _alertType = AlertType.both;

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  String _alertTypeLabel(AlertType type) => switch (type) {
    AlertType.upper => '상한가',
    AlertType.lower => '하한가',
    AlertType.both => '양방향',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('관심 종목 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: '목표가',
              hintText: '목표 가격을 입력하세요',
              border: OutlineInputBorder(),
              suffixText: '원',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SegmentedButton<AlertType>(
            segments: AlertType.values
                .map(
                  (type) => ButtonSegment(
                    value: type,
                    label: Text(_alertTypeLabel(type)),
                  ),
                )
                .toList(),
            selected: {_alertType},
            onSelectionChanged: (selected) {
              setState(() => _alertType = selected.first);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: () {
            final price = int.tryParse(_priceController.text);
            if (price == null) return;
            Navigator.pop(context, (targetPrice: price, alertType: _alertType));
          },
          child: const Text('추가'),
        ),
      ],
    );
  }
}
