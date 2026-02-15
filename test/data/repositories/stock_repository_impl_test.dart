import 'package:fake_async/fake_async.dart';
import 'package:flutter_coding_test/data/ezar/ezar.dart';
import 'package:flutter_coding_test/data/repositories/stock_repository_impl.dart';
import 'package:flutter_coding_test/domain/stock/entities/stock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockRepositoryImpl', () {
    late StockRepositoryImpl repository;

    setUp(() {
      repository = StockRepositoryImpl(
        StockDataSourceEzar(),
        StockTickDataSourceEzar(),
      );
    });

    tearDown(() {
      repository.disconnect();
    });

    group('getStock', () {
      test('종목 데이터를 반환해야 한다', () async {
        final stock = await repository.getStock('005930');
        expect(stock.code, '005930');
        expect(stock.name, '삼성전자');
        expect(stock.currentPrice, greaterThan(0));
      });
    });

    group('stockTickStream', () {
      test('tick 수신 시 종목 가격 업데이트를 emit해야 한다', () {
        fakeAsync((async) {
          final emissions = <Stock>[];
          repository.stockTickStream('005930').listen(emissions.add);

          repository.connect();
          async.elapse(const Duration(seconds: 5));
          expect(emissions.length, greaterThanOrEqualTo(1));
        });
      });
    });
  });
}
