import 'dart:async';

import 'package:flutter_coding_test/data/ezar/ezar.dart';
import 'package:flutter_coding_test/domain/stock/entities/stock.dart';
import 'package:flutter_coding_test/domain/stock/repos/stock_repository.dart';
import 'package:rxdart/rxdart.dart';

class StockRepositoryImpl implements StockRepository {
  final StockDataSourceEzar _stockDataSourceEzar;
  final StockTickDataSourceEzar _stockTickDataSourceEzar;
  final _subject = BehaviorSubject<List<Stock>>();
  StreamSubscription<StockTickMessage>? _subscription;

  StockRepositoryImpl(this._stockDataSourceEzar, this._stockTickDataSourceEzar);

  @override
  Stream<List<Stock>> get stocksStream => _subject.stream;

  @override
  Future<Stock> getStock(String code) async {
    final model = await _stockDataSourceEzar.getStock(code);
    if (model == null) {
      throw ArgumentError('존재하지 않는 종목 코드: $code');
    }

    return Stock(
      code: model.code,
      name: model.name,
      currentPrice: model.currentPrice,
      changeRate: model.changeRate,
      updatedAt: model.updatedAt,
    );
  }

  Future<void> connect() async {
    final models = await _stockDataSourceEzar.getStocks();
    final stocks = models
        .map(
          (m) => Stock(
            code: m.code,
            name: m.name,
            currentPrice: m.currentPrice,
            changeRate: m.changeRate,
            updatedAt: m.updatedAt,
          ),
        )
        .toList();
    _subject.add(stocks);

    _stockTickDataSourceEzar.connect();
    _subscription = _stockTickDataSourceEzar.messageStream.listen((tick) {
      if (tick.type != 'price_update') {
        throw UnimplementedError('미구현 메시지 타입: ${tick.type}');
      }

      final updated = _subject.value.map((stock) {
        if (stock.code == tick.stockCode) {
          return stock.copyWith(
            currentPrice: tick.currentPrice,
            changeRate: tick.changeRate,
            updatedAt: tick.timestamp,
          );
        }
        return stock;
      }).toList();
      _subject.add(updated);
    });
  }

  void disconnect() {
    _subscription?.cancel();
    _stockTickDataSourceEzar.disconnect();
    _subject.close();
  }
}
