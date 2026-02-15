import 'package:flutter_coding_test/data/ezar/datasources/stock_data_source_ezar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockDataSourceEzar', () {
    late StockDataSourceEzar dataSource;

    setUp(() {
      dataSource = StockDataSourceEzar();
    });

    group('getStock', () {
      test('종목 코드로 조회하면 해당 종목을 반환해야 한다', () async {
        final stock = await dataSource.getStock('005930');

        expect(stock.code, '005930');
        expect(stock.name, '삼성전자');
        expect(stock.currentPrice, greaterThan(0));
      });
    });
  });
}
