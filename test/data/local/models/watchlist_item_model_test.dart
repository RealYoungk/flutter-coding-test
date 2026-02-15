import 'package:flutter_coding_test/data/local/models/watchlist_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistItemModel', () {
    group('생성', () {
      test('디폴트 값으로 정상 생성되어야 한다', () {
        final model = WatchlistItemModel();

        expect(model.stockCode, '');
        expect(model.targetPrice, null);
        expect(model.alertTypeName, 'both');
        expect(model.createdAt, DateTime.fromMillisecondsSinceEpoch(0));
      });

      test('모든 필드를 지정하여 생성할 수 있어야 한다', () {
        final createdAt = DateTime(2024, 1, 15);

        final model = WatchlistItemModel(
          stockCode: '005930',
          targetPrice: 75000,
          alertTypeName: 'upper',
          createdAt: createdAt,
        );

        expect(model.stockCode, '005930');
        expect(model.targetPrice, 75000);
        expect(model.alertTypeName, 'upper');
        expect(model.createdAt, createdAt);
      });

      test('targetPrice가 null이어도 생성 가능해야 한다', () {
        final model = WatchlistItemModel(
          stockCode: '005930',
          alertTypeName: 'both',
        );

        expect(model.targetPrice, null);
      });
    });

    group('필드 불변성', () {
      test('final 필드는 변경할 수 없어야 한다', () {
        final model = WatchlistItemModel(
          stockCode: '005930',
          targetPrice: 75000,
          alertTypeName: 'upper',
          createdAt: DateTime(2024, 1, 15),
        );

        expect(model.stockCode, '005930');
        expect(model.targetPrice, 75000);
        expect(model.alertTypeName, 'upper');
      });
    });
  });
}
