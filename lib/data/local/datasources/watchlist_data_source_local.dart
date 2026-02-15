import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:flutter_coding_test/data/local/models/watchlist_item_model.dart';

class WatchlistDataSourceLocal {
  static const String boxName = 'watchlist';

  final Box<WatchlistItemModel> _box;

  @visibleForTesting
  WatchlistDataSourceLocal(this._box);

  static Future<WatchlistDataSourceLocal> init() async {
    final box = await Hive.openBox<WatchlistItemModel>(boxName);
    return WatchlistDataSourceLocal(box);
  }

  List<WatchlistItemModel> getAll() {
    return _box.values.toList();
  }

  Future<void> add(WatchlistItemModel item) async {
    await _box.put(item.stockCode, item);
  }

  Future<void> remove(String stockCode) async {
    await _box.delete(stockCode);
  }

  Future<void> update(WatchlistItemModel item) async {
    await _box.put(item.stockCode, item);
  }
}
