import 'package:const_date_time/const_date_time.dart';
import 'package:flutter_coding_test/data/local/models/watchlist_item_model.dart';
import 'package:flutter_coding_test/domain/watchlist/entities/alert_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistItemModel', () {
    group('생성', () {
      test('디폴트 값으로 정상 생성되어야 한다', () {
        // Arrange & Act
        const model = WatchlistItemModel();

        // Assert
        expect(model.stockCode, '');
        expect(model.targetPrice, null);
        expect(model.alertType, AlertType.both);
        expect(model.createdAt, const ConstDateTime(0));
      });

      test('모든 필드를 지정하여 생성할 수 있어야 한다', () {
        // Arrange
        final createdAt = DateTime(2024, 1, 15);

        // Act
        final model = WatchlistItemModel(
          stockCode: '005930',
          targetPrice: 75000,
          alertType: AlertType.upper,
          createdAt: createdAt,
        );

        // Assert
        expect(model.stockCode, '005930');
        expect(model.targetPrice, 75000);
        expect(model.alertType, AlertType.upper);
        expect(model.createdAt, createdAt);
      });
    });

    group('동등성', () {
      test('동등한 객체는 같다고 판단해야 한다', () {
        // Arrange
        final createdAt = DateTime(2024, 1, 15);

        final model1 = WatchlistItemModel(
          stockCode: '005930',
          targetPrice: 75000,
          alertType: AlertType.both,
          createdAt: createdAt,
        );

        final model2 = WatchlistItemModel(
          stockCode: '005930',
          targetPrice: 75000,
          alertType: AlertType.both,
          createdAt: createdAt,
        );

        // Act & Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });
    });

    group('copyWith', () {
      test('copyWith로 필드를 변경할 수 있어야 한다', () {
        // Arrange
        final originalCreatedAt = DateTime(2024, 1, 15);
        final newCreatedAt = DateTime(2024, 1, 16);

        final original = WatchlistItemModel(
          stockCode: '005930',
          targetPrice: 75000,
          alertType: AlertType.both,
          createdAt: originalCreatedAt,
        );

        // Act
        final copied = original.copyWith(
          stockCode: '035720',
          targetPrice: 50000,
          alertType: AlertType.lower,
          createdAt: newCreatedAt,
        );

        // Assert
        expect(copied.stockCode, '035720');
        expect(copied.targetPrice, 50000);
        expect(copied.alertType, AlertType.lower);
        expect(copied.createdAt, newCreatedAt);

        // Original should remain unchanged
        expect(original.stockCode, '005930');
        expect(original.targetPrice, 75000);
        expect(original.alertType, AlertType.both);
        expect(original.createdAt, originalCreatedAt);
      });
    });
  });
}
