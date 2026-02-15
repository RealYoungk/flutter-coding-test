import 'package:collection/collection.dart';

import 'models/stock_model.dart';

// TODO(youngjin.kim): 실제 HTTP API 연결로 교체
class StockDataSourceEzar {
  final List<StockModel> _stocks = [
    StockModel(
      code: '005930',
      name: '삼성전자',
      logoUrl: '',
      currentPrice: 72000,
      changeRate: 0.0,
      updatedAt: DateTime.now(),
    ),
    StockModel(
      code: '000660',
      name: 'SK하이닉스',
      logoUrl: '',
      currentPrice: 135000,
      changeRate: 0.0,
      updatedAt: DateTime.now(),
    ),
    StockModel(
      code: '035720',
      name: '카카오',
      logoUrl: '',
      currentPrice: 55000,
      changeRate: 0.0,
      updatedAt: DateTime.now(),
    ),
    StockModel(
      code: '035420',
      name: 'NAVER',
      logoUrl: '',
      currentPrice: 210000,
      changeRate: 0.0,
      updatedAt: DateTime.now(),
    ),
    StockModel(
      code: '005380',
      name: '현대차',
      logoUrl: '',
      currentPrice: 185000,
      changeRate: 0.0,
      updatedAt: DateTime.now(),
    ),
  ];

  Future<List<StockModel>> getStocks() {
    return Future.value(_stocks);
  }

  Future<StockModel?> getStock(String code) {
    return Future.value(_stocks.firstWhereOrNull((s) => s.code == code));
  }
}
