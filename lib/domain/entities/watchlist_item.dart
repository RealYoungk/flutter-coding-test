import 'package:const_date_time/const_date_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_coding_test/domain/entities/alert_type.dart';

part 'watchlist_item.freezed.dart';

@freezed
abstract class WatchlistItem with _$WatchlistItem {
  const factory WatchlistItem({
    @Default('') String stockCode,
    int? targetPrice,
    @Default(AlertType.both) AlertType alertType,
    @Default(ConstDateTime(0)) DateTime createdAt,
  }) = _WatchlistItem;
}
