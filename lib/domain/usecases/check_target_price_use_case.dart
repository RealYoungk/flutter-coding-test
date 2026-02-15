import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';

class CheckTargetPriceUseCase {
  const CheckTargetPriceUseCase(this._repository);

  final WatchlistRepository _repository;

  Future<({WatchlistItem item, bool isUpper})?> call({
    required String stockCode,
    required int prevPrice,
    required int currentPrice,
  }) async {
    final watchlist = await _repository.getWatchlist();
    final item = watchlist.cast<WatchlistItem?>().firstWhere(
      (e) => e!.stockCode == stockCode,
      orElse: () => null,
    );
    final targetPrice = item?.targetPrice;
    if (item == null || targetPrice == null) return null;

    final crossedUp = prevPrice < targetPrice && currentPrice >= targetPrice;
    final crossedDown = prevPrice > targetPrice && currentPrice <= targetPrice;

    final reached = switch (item.alertType) {
      AlertType.upper => crossedUp,
      AlertType.lower => crossedDown,
      AlertType.both => crossedUp || crossedDown,
    };

    return reached ? (item: item, isUpper: crossedUp) : null;
  }
}
