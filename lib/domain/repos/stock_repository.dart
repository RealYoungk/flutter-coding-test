import 'package:flutter_coding_test/domain/entities/stock.dart';

abstract class StockRepository {
  Stream<Stock> getPriceStream();
  Future<Stock?> getStock(String code);
}
