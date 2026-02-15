import 'package:fake_async/fake_async.dart';
import 'package:flutter_coding_test/data/ezar/ezar.dart';
import 'package:flutter_coding_test/data/repositories/stock_repository_impl.dart';
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
      test('존재하는 종목 코드로 조회하면 Stock 엔티티를 반환해야 한다', () async {
        final stock = await repository.getStock('005930');

        expect(stock.code, '005930');
        expect(stock.name, '삼성전자');
        expect(stock.currentPrice, greaterThan(0));
      });

      test('존재하지 않는 종목 코드로 조회하면 예외를 던져야 한다', () async {
        expect(
          () => repository.getStock('999999'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('connect', () {
      test('연결 후 초기 종목 리스트를 emit해야 한다', () async {
        await repository.connect();

        final stocks = await repository.stocksStream.first;
        expect(stocks, hasLength(5));

        for (final stock in stocks) {
          expect(stock.code, isNotEmpty);
          expect(stock.name, isNotEmpty);
          expect(stock.currentPrice, greaterThan(0));
        }
      });

      test('tick 수신 시 해당 종목의 가격이 업데이트되어야 한다', () {
        fakeAsync((async) {
          final emissions = <List<dynamic>>[];
          repository.stocksStream.listen(emissions.add);

          repository.connect();
          async.flushMicrotasks();
          expect(emissions, hasLength(1));

          async.elapse(const Duration(seconds: 1));
          expect(emissions, hasLength(2));

          final updated = emissions.last;
          expect(updated, hasLength(5));
        });
      });

      test('tick 수신 후에도 종목 수는 변하지 않아야 한다', () {
        fakeAsync((async) {
          final emissions = <List<dynamic>>[];
          repository.stocksStream.listen(emissions.add);

          repository.connect();
          async.flushMicrotasks();

          async.elapse(const Duration(seconds: 5));

          for (final list in emissions) {
            expect(list, hasLength(5));
          }
        });
      });
    });
  });
}
