import 'package:flutter/material.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_summary_row_view.dart';

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
          const StockSummaryRowView(label: '시가총액', value: '432조 원'),
          const StockSummaryRowView(label: 'PER', value: '12.5'),
          const StockSummaryRowView(label: 'PBR', value: '1.3'),
          const StockSummaryRowView(label: '52주 최고', value: '78,000원'),
          const StockSummaryRowView(label: '52주 최저', value: '59,000원'),
        ],
      ),
    );
  }
}
