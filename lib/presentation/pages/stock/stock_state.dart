import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_state.freezed.dart';

@freezed
abstract class StockState with _$StockState {
  const StockState._();

  const factory StockState({
    Stock? stock,
    @Default([]) List<WatchlistItem> watchlist,
    ({WatchlistItem item, bool isUpper})? triggeredAlert,
    @Default(false) bool hasError,
  }) = _StockState;

  bool get isLoading => stock == null && !hasError;
  Stock get stockOrDefault => stock ?? const Stock();
  bool get isInWatchlist =>
      watchlist.any((item) => item.stockCode == stockOrDefault.code);
}
