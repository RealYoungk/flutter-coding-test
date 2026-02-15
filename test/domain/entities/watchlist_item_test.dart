import 'package:const_date_time/const_date_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_coding_test/domain/entities/watchlist_item.dart';
import 'package:flutter_coding_test/domain/entities/alert_type.dart';

void main() {
  group('WatchlistItem', () {
    final testDateTime = DateTime(2024, 1, 1, 12, 0, 0);

    group('생성', () {
      test('필수 필드만으로 정상 생성되어야 한다', () {
        final item = WatchlistItem(
          stockCode: 'AAPL',
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item.stockCode, 'AAPL');
        expect(item.targetPrice, isNull);
        expect(item.alertType, AlertType.upper);
        expect(item.createdAt, testDateTime);
      });

      test('targetPrice가 null이어도 생성 가능해야 한다', () {
        final item = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: null,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item.targetPrice, isNull);
      });

      test('targetPrice 값이 정상 저장되어야 한다', () {
        final item = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item.targetPrice, 150000);
      });
    });

    group('디폴트 값', () {
      test('인자 없이 생성하면 stockCode는 빈 문자열이어야 한다', () {
        const item = WatchlistItem();

        expect(item.stockCode, '');
      });

      test('인자 없이 생성하면 targetPrice는 null이어야 한다', () {
        const item = WatchlistItem();

        expect(item.targetPrice, isNull);
      });

      test('인자 없이 생성하면 alertType은 AlertType.both이어야 한다', () {
        const item = WatchlistItem();

        expect(item.alertType, AlertType.both);
      });

      test('인자 없이 생성하면 createdAt은 ConstDateTime(0)이어야 한다', () {
        const item = WatchlistItem();

        expect(item.createdAt, const ConstDateTime(0));
      });
    });

    group('동등성 (equality)', () {
      test('모든 필드가 같으면 동일 객체로 판단해야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item1, equals(item2));
        expect(item1 == item2, isTrue);
      });

      test('stockCode가 다르면 다른 객체로 판단해야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'GOOGL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item1, isNot(equals(item2)));
        expect(item1 == item2, isFalse);
      });

      test('targetPrice가 다르면 다른 객체로 판단해야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 160000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item1, isNot(equals(item2)));
        expect(item1 == item2, isFalse);
      });

      test('alertType이 다르면 다른 객체로 판단해야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.lower,
          createdAt: testDateTime,
        );

        expect(item1, isNot(equals(item2)));
        expect(item1 == item2, isFalse);
      });

      test('createdAt이 다르면 다른 객체로 판단해야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: DateTime(2024, 1, 2, 12, 0, 0),
        );

        expect(item1, isNot(equals(item2)));
        expect(item1 == item2, isFalse);
      });
    });

    group('copyWith', () {
      test('stockCode만 변경한 복사본을 생성할 수 있어야 한다', () {
        final original = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final copied = original.copyWith(stockCode: 'GOOGL');

        expect(copied.stockCode, 'GOOGL');
        expect(copied.targetPrice, 150000);
        expect(copied.alertType, AlertType.upper);
        expect(copied.createdAt, testDateTime);
      });

      test('targetPrice만 변경한 복사본을 생성할 수 있어야 한다', () {
        final original = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final copied = original.copyWith(targetPrice: 160000);

        expect(copied.stockCode, 'AAPL');
        expect(copied.targetPrice, 160000);
        expect(copied.alertType, AlertType.upper);
        expect(copied.createdAt, testDateTime);
      });

      test('alertType만 변경한 복사본을 생성할 수 있어야 한다', () {
        final original = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final copied = original.copyWith(alertType: AlertType.both);

        expect(copied.stockCode, 'AAPL');
        expect(copied.targetPrice, 150000);
        expect(copied.alertType, AlertType.both);
        expect(copied.createdAt, testDateTime);
      });

      test('createdAt만 변경한 복사본을 생성할 수 있어야 한다', () {
        final original = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final newDateTime = DateTime(2024, 1, 2, 12, 0, 0);
        final copied = original.copyWith(createdAt: newDateTime);

        expect(copied.stockCode, 'AAPL');
        expect(copied.targetPrice, 150000);
        expect(copied.alertType, AlertType.upper);
        expect(copied.createdAt, newDateTime);
      });

      test('targetPrice를 null로 변경할 수 있어야 한다', () {
        final original = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final copied = original.copyWith(targetPrice: null);

        expect(copied.stockCode, 'AAPL');
        expect(copied.targetPrice, isNull);
        expect(copied.alertType, AlertType.upper);
        expect(copied.createdAt, testDateTime);
      });

      test('여러 필드를 동시에 변경할 수 있어야 한다', () {
        final original = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final copied = original.copyWith(
          stockCode: 'GOOGL',
          targetPrice: 200000,
          alertType: AlertType.both,
        );

        expect(copied.stockCode, 'GOOGL');
        expect(copied.targetPrice, 200000);
        expect(copied.alertType, AlertType.both);
        expect(copied.createdAt, testDateTime);
      });
    });

    group('toString', () {
      test('targetPrice 포함 시 문자열에 주요 정보가 포함되어야 한다', () {
        final item = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final stringRep = item.toString();

        expect(stringRep, contains('AAPL'));
        expect(stringRep, contains('150000'));
        expect(stringRep, contains('AlertType.upper'));
      });

      test('targetPrice 미포함 시에도 문자열이 정상 출력되어야 한다', () {
        final item = WatchlistItem(
          stockCode: 'AAPL',
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final stringRep = item.toString();

        expect(stringRep, contains('AAPL'));
        expect(stringRep, contains('AlertType.upper'));
      });
    });

    group('hashCode', () {
      test('동일 객체의 hashCode는 일관되어야 한다', () {
        final item = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final hashCode1 = item.hashCode;
        final hashCode2 = item.hashCode;

        expect(hashCode1, equals(hashCode2));
      });

      test('동등한 객체는 같은 hashCode를 가져야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item1.hashCode, equals(item2.hashCode));
      });

      test('다른 객체는 다른 hashCode를 가져야 한다', () {
        final item1 = WatchlistItem(
          stockCode: 'AAPL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        final item2 = WatchlistItem(
          stockCode: 'GOOGL',
          targetPrice: 150000,
          alertType: AlertType.upper,
          createdAt: testDateTime,
        );

        expect(item1.hashCode, isNot(equals(item2.hashCode)));
      });
    });
  });
}
