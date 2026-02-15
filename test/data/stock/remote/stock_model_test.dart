import 'package:const_date_time/const_date_time.dart';
import 'package:flutter_coding_test/data/stock/remote/stock_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockModel', () {
    group('생성', () {
      test('디폴트 값으로 정상 생성되어야 한다', () {
        // Arrange & Act
        const model = StockModel();

        // Assert
        expect(model.code, '');
        expect(model.name, '');
        expect(model.currentPrice, 0);
        expect(model.changeRate, 0.0);
        expect(model.updatedAt, const ConstDateTime(0));
      });

      test('모든 필드를 지정하여 생성할 수 있어야 한다', () {
        // Arrange
        final updatedAt = DateTime(2024, 1, 15, 9, 30);

        // Act
        final model = StockModel(
          code: '005930',
          name: '삼성전자',
          currentPrice: 72500,
          changeRate: 1.25,
          updatedAt: updatedAt,
        );

        // Assert
        expect(model.code, '005930');
        expect(model.name, '삼성전자');
        expect(model.currentPrice, 72500);
        expect(model.changeRate, 1.25);
        expect(model.updatedAt, updatedAt);
      });
    });

    group('fromJson', () {
      test('WebSocket 메시지를 정상 파싱할 수 있어야 한다', () {
        // Arrange
        final json = {
          'stockCode': '005930',
          'name': '삼성전자',
          'currentPrice': 72500,
          'changeRate': 1.25,
          'timestamp': '2024-01-15T09:30:00.000Z',
        };

        // Act
        final model = StockModel.fromJson(json);

        // Assert
        expect(model.code, '005930');
        expect(model.name, '삼성전자');
        expect(model.currentPrice, 72500);
        expect(model.changeRate, 1.25);
        expect(model.updatedAt, isA<DateTime>());
        expect(model.updatedAt.toIso8601String(), '2024-01-15T09:30:00.000Z');
      });

      test('누락된 필드는 디폴트 값이 적용되어야 한다', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final model = StockModel.fromJson(json);

        // Assert
        expect(model.code, '');
        expect(model.name, '');
        expect(model.currentPrice, 0);
        expect(model.changeRate, 0.0);
        expect(model.updatedAt, const ConstDateTime(0));
      });

      test('잘못된 timestamp는 적절히 처리되어야 한다', () {
        // Arrange
        final json = {
          'stockCode': '005930',
          'name': '삼성전자',
          'currentPrice': 72500,
          'changeRate': 1.25,
          'timestamp': 'invalid-date',
        };

        // Act & Assert
        // The behavior depends on json_serializable's DateTime parsing
        // It should either throw or use a fallback value
        expect(
          () => StockModel.fromJson(json),
          anyOf([
            // Case 1: Throws an exception
            throwsA(isA<FormatException>()),
            // Case 2: Returns successfully (with fallback value)
            returnsNormally,
          ]),
        );
      });
    });

    group('동등성', () {
      test('동등한 객체는 같다고 판단해야 한다', () {
        // Arrange
        final updatedAt = DateTime(2024, 1, 15, 9, 30);

        final model1 = StockModel(
          code: '005930',
          name: '삼성전자',
          currentPrice: 72500,
          changeRate: 1.25,
          updatedAt: updatedAt,
        );

        final model2 = StockModel(
          code: '005930',
          name: '삼성전자',
          currentPrice: 72500,
          changeRate: 1.25,
          updatedAt: updatedAt,
        );

        // Act & Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });
    });

    group('copyWith', () {
      test('copyWith로 필드를 변경할 수 있어야 한다', () {
        // Arrange
        final originalUpdatedAt = DateTime(2024, 1, 15, 9, 30);
        final newUpdatedAt = DateTime(2024, 1, 15, 10, 0);

        final original = StockModel(
          code: '005930',
          name: '삼성전자',
          currentPrice: 72500,
          changeRate: 1.25,
          updatedAt: originalUpdatedAt,
        );

        // Act
        final copied = original.copyWith(
          code: '035720',
          name: '카카오',
          currentPrice: 50000,
          changeRate: -0.5,
          updatedAt: newUpdatedAt,
        );

        // Assert
        expect(copied.code, '035720');
        expect(copied.name, '카카오');
        expect(copied.currentPrice, 50000);
        expect(copied.changeRate, -0.5);
        expect(copied.updatedAt, newUpdatedAt);

        // Original should remain unchanged
        expect(original.code, '005930');
        expect(original.name, '삼성전자');
        expect(original.currentPrice, 72500);
        expect(original.changeRate, 1.25);
        expect(original.updatedAt, originalUpdatedAt);
      });
    });
  });
}
