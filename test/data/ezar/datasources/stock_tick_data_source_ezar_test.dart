import 'package:fake_async/fake_async.dart';
import 'package:flutter_coding_test/data/ezar/datasources/stock_tick_data_source_ezar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockTickDataSourceEzar', () {
    late StockTickDataSourceEzar dataSource;

    setUp(() {
      dataSource = StockTickDataSourceEzar();
    });

    tearDown(() {
      dataSource.disconnect();
    });

    group('connect', () {
      test('연결 후 5초마다 메시지를 수신해야 한다', () {
        fakeAsync((async) {
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          expect(messages, isEmpty);

          async.elapse(const Duration(seconds: 5));
          expect(messages, hasLength(1));

          async.elapse(const Duration(seconds: 10));
          expect(messages, hasLength(3));
        });
      });

      test('수신된 메시지의 type은 price_update이어야 한다', () {
        fakeAsync((async) {
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          async.elapse(const Duration(seconds: 5));

          expect(messages.first.type, 'price_update');
        });
      });

      test('수신된 메시지의 stockCode는 유효한 종목 코드이어야 한다', () {
        fakeAsync((async) {
          const validCodes = ['005930', '000660', '035720', '035420', '005380'];
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          async.elapse(const Duration(seconds: 5));

          for (final message in messages) {
            expect(validCodes, contains(message.stockCode));
          }
        });
      });

      test('수신된 메시지의 가격은 적절한 범위이어야 한다', () {
        fakeAsync((async) {
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          async.elapse(const Duration(seconds: 5));

          for (final message in messages) {
            expect(message.currentPrice, greaterThanOrEqualTo(50000));
            expect(message.currentPrice, lessThan(250000));
          }
        });
      });

      test('수신된 메시지의 변동률은 -3% ~ 3% 범위이어야 한다', () {
        fakeAsync((async) {
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          async.elapse(const Duration(seconds: 5));

          for (final message in messages) {
            expect(message.changeRate, greaterThanOrEqualTo(-3.0));
            expect(message.changeRate, lessThan(3.0));
          }
        });
      });

      test('수신된 메시지의 timestamp는 null이 아니어야 한다', () {
        fakeAsync((async) {
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          async.elapse(const Duration(seconds: 5));

          expect(messages.first.timestamp, isNotNull);
        });
      });
    });

    group('disconnect', () {
      test('연결 해제 후 메시지를 수신하지 않아야 한다', () {
        fakeAsync((async) {
          final messages = <dynamic>[];
          dataSource.messageStream.listen(messages.add);

          dataSource.connect();
          async.elapse(const Duration(seconds: 10));
          expect(messages, hasLength(2));

          dataSource.disconnect();
          async.elapse(const Duration(seconds: 15));
          expect(messages, hasLength(2));
        });
      });
    });
  });
}
