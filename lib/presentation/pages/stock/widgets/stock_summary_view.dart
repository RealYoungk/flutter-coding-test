import 'package:flutter/material.dart';

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
          const _SummaryInfoRow(label: '시가총액', value: '432조 원'),
          const _SummaryInfoRow(label: 'PER', value: '12.5'),
          const _SummaryInfoRow(label: 'PBR', value: '1.3'),
          const _SummaryInfoRow(label: '52주 최고', value: '78,000원'),
          const _SummaryInfoRow(label: '52주 최저', value: '59,000원'),
        ],
      ),
    );
  }
}

class _SummaryInfoRow extends StatelessWidget {
  const _SummaryInfoRow({required this.label, required this.value});

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
