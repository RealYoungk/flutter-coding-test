import 'package:flutter/material.dart';

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
