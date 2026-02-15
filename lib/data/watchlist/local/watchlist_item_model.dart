import 'package:const_date_time/const_date_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_coding_test/domain/watchlist/entities/alert_type.dart';

part 'watchlist_item_model.freezed.dart';

@freezed
abstract class WatchlistItemModel with _$WatchlistItemModel {
  const factory WatchlistItemModel({
    @Default('') String stockCode,
    int? targetPrice,
    @Default(AlertType.both) AlertType alertType,
    @Default(ConstDateTime(0)) DateTime createdAt,
  }) = _WatchlistItemModel;
}
