import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';

class ToggleWatchlistUseCase {
  const ToggleWatchlistUseCase(this._repository);

  final WatchlistRepository _repository;

  Future<void> call({
    required WatchlistItem item,
    required bool isInWatchlist,
  }) async {
    if (isInWatchlist) {
      await _repository.removeItem(item.stockCode);
    } else {
      await _repository.addItem(item);
    }
  }
}
