import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_test/presentation/stock/stock_provider.dart';
import 'package:provider/provider.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StockProvider>();
    return DefaultTabController(
      length: provider.sectionTitles.length,
      child: Scaffold(
        appBar: const StockAppBarView(),
        body: ListView(
          children: const [
            StockPriceView(),
            Divider(),
            StockSummaryView(),
            Divider(),
            StockInputView(),
            Divider(),
            StockExpansionView(),
            Divider(),
            StockEtcView(),
          ],
        ),
      ),
    );
  }
}

class StockAppBarView extends StatelessWidget implements PreferredSizeWidget {
  const StockAppBarView({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StockProvider>();
    return AppBar(
      title: const Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
            child: Text('삼', style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('삼성전자', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('005930', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
      bottom: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: provider.sectionTitles.map((title) => Tab(text: title)).toList(),
        onTap: (index) {
          // TODO(youngjin.kim): 해당 섹션으로 스크롤 이동
        },
      ),
    );
  }
}

class StockPriceView extends StatelessWidget {
  const StockPriceView();

  static const _mockSpots = [
    FlSpot(0, 71000),
    FlSpot(1, 71500),
    FlSpot(2, 70800),
    FlSpot(3, 72000),
    FlSpot(4, 71200),
    FlSpot(5, 72500),
    FlSpot(6, 73000),
    FlSpot(7, 72800),
    FlSpot(8, 73500),
    FlSpot(9, 72500),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '가격',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '72,500',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text(
                '원',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(width: 12),
              Text(
                '+1.25%',
                style: TextStyle(fontSize: 16, color: Colors.red),
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
                    spots: _mockSpots,
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red.withAlpha(30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
  const StockSummaryInfoView({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
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
