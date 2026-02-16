import 'package:flutter/material.dart';
import 'package:flutter_coding_test/presentation/hooks/use_tab_scroll_controller.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_app_bar_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_etc_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_expansion_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_input_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_price_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_summary_view.dart';
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
