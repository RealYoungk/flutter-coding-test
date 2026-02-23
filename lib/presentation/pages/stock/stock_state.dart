import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_state.freezed.dart';

@freezed
abstract class StockState with _$StockState {
  const StockState._();

  const factory StockState({
    @Default(Stock()) Stock stock,
    @Default(true) bool isLoading,
    @Default([]) List<WatchlistItem> watchlist,
  }) = _StockState;

  bool get hasError => !isLoading && stock.code.isEmpty;
  bool get isInWatchlist =>
      watchlist.any((item) => item.stockCode == stock.code);

  ({String stockCode, int targetPrice, bool isUpper})? get needsTargetPriceAlert {
    final history = stock.priceHistory;
    if (history.length < 2) return null;
    final item = watchlist
        .where((e) => e.stockCode == stock.code)
        .firstOrNull;
    if (item == null || item.targetPrice == null) return null;
    final prevPrice = history[history.length - 2];
    final currentPrice = history.last;
    final targetPrice = item.targetPrice!;
    final crossedUp = prevPrice < targetPrice && currentPrice >= targetPrice;
    final crossedDown = prevPrice > targetPrice && currentPrice <= targetPrice;
    final reached = switch (item.alertType) {
      AlertType.upper => crossedUp,
      AlertType.lower => crossedDown,
      AlertType.both => crossedUp || crossedDown,
    };
    if (!reached) return null;
    return (stockCode: item.stockCode, targetPrice: targetPrice, isUpper: crossedUp);
  }
}
