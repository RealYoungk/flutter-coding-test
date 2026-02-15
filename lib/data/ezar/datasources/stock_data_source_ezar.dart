import '../models/stock_model.dart';

// TODO(youngjin.kim): 실제 HTTP API 연결로 교체
class StockDataSourceEzar {
  Future<StockModel> getStock(String code) {
    return Future.value(
      StockModel(
        code: '005930',
        name: '삼성전자',
        logoUrl: 'https://picsum.photos/64',
        changeRate: 1.25,
        priceHistory: [
          71000,
          71500,
          70800,
          72000,
          71200,
          72500,
          73000,
          72800,
          73500,
          72500,
        ],
        updatedAt: DateTime.now(),
      ),
    );
  }
}
