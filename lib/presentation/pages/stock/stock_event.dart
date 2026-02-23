import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_event.freezed.dart';

@freezed
sealed class StockEvent with _$StockEvent {
  const factory StockEvent.initialized({required String stockCode}) =
      StockInitialized;
  const factory StockEvent.favoriteToggled({required String stockCode}) =
      StockFavoriteToggled;
  const factory StockEvent.watchlistAdded({
    required String stockCode,
    required int targetPrice,
    required AlertType alertType,
  }) = StockWatchlistAdded;
  const factory StockEvent.tickReceived({required Stock tick}) =
      StockTickReceived;
}
