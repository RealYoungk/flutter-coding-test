import '../models/stock_model.dart';

// TODO(youngjin.kim): 실제 HTTP API 연결로 교체
class StockDataSourceEzar {
  Future<StockModel> getStock(String code) {
    return Future.value(StockModel(
      code: '005930',
      name: '삼성전자',
      logoUrl: 'https://example.com/logos/005930.png',
      currentPrice: 72500,
      changeRate: 1.25,
      updatedAt: DateTime.now(),
    ));
  }
}
