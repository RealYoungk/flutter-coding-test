import 'package:flutter_coding_test/domain/stock/entities/stock.dart';

abstract interface class StockRepository {
  Future<Stock> getStock(String code);
  Stream<Stock> stockTickStream(String code);
  Future<void> connect();
  void disconnect();
}
