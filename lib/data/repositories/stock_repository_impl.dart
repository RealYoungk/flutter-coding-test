import 'dart:async';

import 'package:flutter_coding_test/data/ezar/ezar.dart';
import 'package:flutter_coding_test/domain/stock/entities/stock.dart';
import 'package:flutter_coding_test/domain/stock/repos/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final StockDataSourceEzar _stockDataSourceEzar;
  final StockTickDataSourceEzar _stockTickDataSourceEzar;

  StockRepositoryImpl(this._stockDataSourceEzar, this._stockTickDataSourceEzar);

  @override
  Future<Stock> getStock(String code) async {
    final model = await _stockDataSourceEzar.getStock(code);
    return Stock(
      code: model.code,
      name: model.name,
      logoUrl: model.logoUrl,
      currentPrice: model.currentPrice,
      changeRate: model.changeRate,
      updatedAt: model.updatedAt,
    );
  }

  @override
  Stream<Stock> stockTickStream(String code) {
    return _stockTickDataSourceEzar.messageStream.where((tick) {
      return tick.stockCode == code;
    }).map((tick) {
      if (tick.type != 'price_update') {
        throw UnimplementedError('미구현 메시지 타입: ${tick.type}');
      }
      return Stock(
        code: tick.stockCode,
        currentPrice: tick.currentPrice,
        changeRate: tick.changeRate,
        updatedAt: tick.timestamp,
      );
    });
  }

  @override
  Future<void> connect() async {
    _stockTickDataSourceEzar.connect();
  }

  @override
  void disconnect() {
    _stockTickDataSourceEzar.disconnect();
  }
}
