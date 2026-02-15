import 'dart:io';

import 'package:flutter_coding_test/data/local/models/watchlist_item_model.dart';
import 'package:flutter_coding_test/data/local/watchlist_data_source_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';

void main() {
  late Directory tempDir;
  late Box<WatchlistItemModel> box;
  late WatchlistDataSourceLocal dataSource;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);

    try {
      Hive.registerAdapter(WatchlistItemModelAdapter());
    } catch (_) {}

    box = await Hive.openBox<WatchlistItemModel>(
      WatchlistDataSourceLocal.boxName,
    );
    dataSource = WatchlistDataSourceLocal(box);
  });

  tearDown(() async {
    await box.clear();
    await box.close();
    await tempDir.delete(recursive: true);
  });

  group('WatchlistDataSourceLocal', () {
    group('getAll', () {
      test('빈 박스에서 빈 리스트를 반환해야 한다', () {
        final result = dataSource.getAll();
        expect(result, isEmpty);
      });

      test('저장된 모든 항목을 반환해야 한다', () async {
        await dataSource.add(
          WatchlistItemModel(stockCode: '005930', targetPrice: 75000),
        );
        await dataSource.add(
          WatchlistItemModel(stockCode: '035720', targetPrice: 50000),
        );

        final result = dataSource.getAll();
        expect(result, hasLength(2));
        expect(result.any((item) => item.stockCode == '005930'), isTrue);
        expect(result.any((item) => item.stockCode == '035720'), isTrue);
      });
    });

    group('add', () {
      test('항목을 추가할 수 있어야 한다', () async {
        await dataSource.add(
          WatchlistItemModel(
            stockCode: '005930',
            targetPrice: 75000,
            alertTypeName: 'upper',
          ),
        );

        final result = dataSource.getAll();
        expect(result, hasLength(1));
        expect(result.first.stockCode, '005930');
        expect(result.first.targetPrice, 75000);
        expect(result.first.alertTypeName, 'upper');
      });

      test('동일한 stockCode로 추가하면 덮어써야 한다', () async {
        await dataSource.add(
          WatchlistItemModel(stockCode: '005930', targetPrice: 75000),
        );
        await dataSource.add(
          WatchlistItemModel(stockCode: '005930', targetPrice: 80000),
        );

        final result = dataSource.getAll();
        expect(result, hasLength(1));
        expect(result.first.targetPrice, 80000);
      });
    });

    group('remove', () {
      test('항목을 삭제할 수 있어야 한다', () async {
        await dataSource.add(
          WatchlistItemModel(stockCode: '005930'),
        );
        expect(dataSource.getAll(), hasLength(1));

        await dataSource.remove('005930');
        expect(dataSource.getAll(), isEmpty);
      });

      test('존재하지 않는 항목 삭제 시 에러가 발생하지 않아야 한다', () async {
        await dataSource.remove('999999');
        expect(dataSource.getAll(), isEmpty);
      });
    });

    group('update', () {
      test('항목을 업데이트할 수 있어야 한다', () async {
        await dataSource.add(
          WatchlistItemModel(
            stockCode: '005930',
            targetPrice: 75000,
            alertTypeName: 'both',
          ),
        );

        await dataSource.update(
          WatchlistItemModel(
            stockCode: '005930',
            targetPrice: 80000,
            alertTypeName: 'upper',
          ),
        );

        final result = dataSource.getAll();
        expect(result, hasLength(1));
        expect(result.first.targetPrice, 80000);
        expect(result.first.alertTypeName, 'upper');
      });
    });
  });
}
