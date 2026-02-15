import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'watchlist_item_model.g.dart';

@HiveType(typeId: 0)
class WatchlistItemModel {
  @HiveField(0)
  final String stockCode;

  @HiveField(1)
  final int? targetPrice;

  @HiveField(2)
  final String alertTypeName;

  @HiveField(3)
  final DateTime createdAt;

  WatchlistItemModel({
    this.stockCode = '',
    this.targetPrice,
    this.alertTypeName = 'both',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
}
