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
  }) = _StockState;

  bool get isLoading => stock == null;
  bool get hasError => stock != null && stock!.code.isEmpty;
  Stock get stockOrDefault => stock ?? const Stock();
  bool get isInWatchlist =>
      watchlist.any((item) => item.stockCode == stockOrDefault.code);
}
