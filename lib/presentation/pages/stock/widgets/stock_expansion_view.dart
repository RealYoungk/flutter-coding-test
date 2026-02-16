import 'package:flutter/material.dart';

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
