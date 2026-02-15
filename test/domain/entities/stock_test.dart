import 'package:const_date_time/const_date_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_coding_test/domain/entities/stock.dart';

void main() {
  group('Stock', () {
    final testDateTime = DateTime(2024, 1, 1, 12, 0, 0);

    group('생성', () {
      test('디폴트 값으로 정상 생성되어야 한다', () {
        const stock = Stock();

        expect(stock.code, '');
        expect(stock.name, '');
        expect(stock.currentPrice, 0);
        expect(stock.changeRate, 0.0);
        expect(stock.updatedAt, const ConstDateTime(0));
      });

      test('모든 필드를 지정하여 생성할 수 있어야 한다', () {
        final stock = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        expect(stock.code, 'AAPL');
        expect(stock.name, 'Apple Inc.');
        expect(stock.currentPrice, 150000);
        expect(stock.changeRate, 2.5);
        expect(stock.updatedAt, testDateTime);
      });
    });

    group('동등성 (equality)', () {
      test('모든 필드가 같으면 동일 객체로 판단해야 한다', () {
        final stock1 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stock2 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        expect(stock1, equals(stock2));
        expect(stock1 == stock2, isTrue);
      });

      test('code가 다르면 다른 객체로 판단해야 한다', () {
        final stock1 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stock2 = Stock(
          code: 'GOOGL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        expect(stock1, isNot(equals(stock2)));
        expect(stock1 == stock2, isFalse);
      });

      test('currentPrice가 다르면 다른 객체로 판단해야 한다', () {
        final stock1 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stock2 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 160000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        expect(stock1, isNot(equals(stock2)));
        expect(stock1 == stock2, isFalse);
      });

      test('changeRate가 다르면 다른 객체로 판단해야 한다', () {
        final stock1 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stock2 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 3.0,
          updatedAt: testDateTime,
        );

        expect(stock1, isNot(equals(stock2)));
        expect(stock1 == stock2, isFalse);
      });
    });

    group('copyWith', () {
      test('currentPrice만 변경한 복사본을 생성할 수 있어야 한다', () {
        final original = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final copied = original.copyWith(currentPrice: 160000);

        expect(copied.code, 'AAPL');
        expect(copied.name, 'Apple Inc.');
        expect(copied.currentPrice, 160000);
        expect(copied.changeRate, 2.5);
        expect(copied.updatedAt, testDateTime);
      });

      test('changeRate만 변경한 복사본을 생성할 수 있어야 한다', () {
        final original = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final copied = original.copyWith(changeRate: 3.0);

        expect(copied.code, 'AAPL');
        expect(copied.name, 'Apple Inc.');
        expect(copied.currentPrice, 150000);
        expect(copied.changeRate, 3.0);
        expect(copied.updatedAt, testDateTime);
      });

      test('여러 필드를 동시에 변경할 수 있어야 한다', () {
        final original = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final newDateTime = DateTime(2024, 1, 2, 12, 0, 0);
        final copied = original.copyWith(
          currentPrice: 160000,
          changeRate: 3.0,
          updatedAt: newDateTime,
        );

        expect(copied.code, 'AAPL');
        expect(copied.name, 'Apple Inc.');
        expect(copied.currentPrice, 160000);
        expect(copied.changeRate, 3.0);
        expect(copied.updatedAt, newDateTime);
      });
    });

    group('toString', () {
      test('문자열에 주요 정보가 포함되어야 한다', () {
        final stock = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stringRep = stock.toString();

        expect(stringRep, contains('AAPL'));
        expect(stringRep, contains('Apple Inc.'));
        expect(stringRep, contains('150000'));
        expect(stringRep, contains('2.5'));
      });
    });

    group('hashCode', () {
      test('동등한 객체는 같은 hashCode를 가져야 한다', () {
        final stock1 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stock2 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        expect(stock1.hashCode, equals(stock2.hashCode));
      });

      test('다른 객체는 다른 hashCode를 가져야 한다', () {
        final stock1 = Stock(
          code: 'AAPL',
          name: 'Apple Inc.',
          currentPrice: 150000,
          changeRate: 2.5,
          updatedAt: testDateTime,
        );

        final stock2 = Stock(
          code: 'GOOGL',
          name: 'Google LLC',
          currentPrice: 160000,
          changeRate: 3.0,
          updatedAt: testDateTime,
        );

        expect(stock1.hashCode, isNot(equals(stock2.hashCode)));
      });
    });
  });
}
