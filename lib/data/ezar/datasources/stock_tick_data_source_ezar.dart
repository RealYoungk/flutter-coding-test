import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import '../models/stock_tick_message.dart';

// TODO(youngjin.kim): 실제 WebSocket 연결로 교체
class StockTickDataSourceEzar {
  final _subject = BehaviorSubject<StockTickMessage>();
  final _random = Random();
  Timer? _timer;

  static const _stockCode = '005930';

  void connect() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _onMessageReceived();
    });
  }

  Stream<StockTickMessage> get messageStream => _subject.stream;

  void disconnect() {
    _timer?.cancel();
    _subject.close();
  }

  void _onMessageReceived() {
    final price = 50000 + _random.nextInt(200000);
    final changeRate = (_random.nextDouble() * 6.0) - 3.0;

    _subject.add(
      StockTickMessage(
        type: 'price_update',
        stockCode: _stockCode,
        currentPrice: price,
        changeRate: double.parse(changeRate.toStringAsFixed(2)),
        timestamp: DateTime.now(),
      ),
    );
  }
}
