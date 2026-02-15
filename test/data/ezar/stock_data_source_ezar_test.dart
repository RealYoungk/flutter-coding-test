import 'package:flutter_coding_test/data/ezar/stock_data_source_ezar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockDataSourceEzar', () {
    late StockDataSourceEzar dataSource;

    setUp(() {
      dataSource = StockDataSourceEzar();
    });

    group('getStocks', () {
      test('모든 종목을 반환해야 한다', () async {
        final stocks = await dataSource.getStocks();

        expect(stocks, hasLength(5));
      });

      test('반환된 종목에 필수 정보가 포함되어야 한다', () async {
        final stocks = await dataSource.getStocks();

        for (final stock in stocks) {
          expect(stock.code, isNotEmpty);
          expect(stock.name, isNotEmpty);
          expect(stock.currentPrice, greaterThan(0));
        }
      });
    });

    group('getStock', () {
      test('존재하는 종목 코드로 조회하면 해당 종목을 반환해야 한다', () async {
        final stock = await dataSource.getStock('005930');

        expect(stock, isNotNull);
        expect(stock!.code, '005930');
        expect(stock.name, '삼성전자');
      });

      test('존재하지 않는 종목 코드로 조회하면 null을 반환해야 한다', () async {
        final stock = await dataSource.getStock('999999');

        expect(stock, isNull);
      });
    });
  });
}
