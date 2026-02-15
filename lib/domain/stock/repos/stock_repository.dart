import 'package:flutter_coding_test/domain/stock/entities/stock.dart';

abstract interface class StockRepository {
  Stream<List<Stock>> get stocksStream;
  Future<Stock> getStock(String code);
  Future<void> connect();
  void disconnect();
}
