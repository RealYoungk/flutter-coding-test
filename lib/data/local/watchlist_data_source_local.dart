import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:flutter_coding_test/data/local/models/watchlist_item_model.dart';

class WatchlistDataSourceLocal {
  static const String boxName = 'watchlist';

  final Box<WatchlistItemModel> _box;

  WatchlistDataSourceLocal(this._box);

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
