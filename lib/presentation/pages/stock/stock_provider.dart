import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';

class StockProvider extends ChangeNotifier {
  StockProvider({
    required StockRepository stockRepository,
    required WatchlistRepository watchlistRepository,
  })  : _stockRepository = stockRepository,
        _watchlistRepository = watchlistRepository;

  final StockRepository _stockRepository;
  final WatchlistRepository _watchlistRepository;

  StreamSubscription<Stock>? _tickSubscription;
  Stock? _stock;
  List<WatchlistItem> _watchlist = [];
  ({WatchlistItem item, bool isUpper})? _triggeredAlert;

  bool get isLoading => _stock == null;
  bool get hasError => _stock != null && _stock!.code.isEmpty;
  Stock get stock => _stock ?? const Stock();
  List<WatchlistItem> get watchlist => _watchlist;
  bool get isInWatchlist =>
      _watchlist.any((item) => item.stockCode == stock.code);
  ({WatchlistItem item, bool isUpper})? get triggeredAlert => _triggeredAlert;

  void onInitialized(String code) async {
    await _fetchStock(code);
    if (hasError) return;
    await _fetchWatchlist();
    await _subscribeTick(code);
  }

  Future<void> onFavoriteToggled(WatchlistItem item) async {
    if (isInWatchlist) {
      await _watchlistRepository.removeItem(item.stockCode);
    } else {
      await _watchlistRepository.addItem(item);
    }
    await _fetchWatchlist();
  }

  Future<void> updateWatchlistItem(WatchlistItem item) async {
    await _watchlistRepository.updateItem(item);
    await _fetchWatchlist();
  }

  void clearAlert() {
    _triggeredAlert = null;
  }

  @override
  void dispose() {
    _tickSubscription?.cancel();
    _stockRepository.disconnect();
    super.dispose();
  }

  Future<void> _fetchStock(String code) async {
    try {
      _stock = await _stockRepository.getStock(code);
    } catch (_) {
      _stock = const Stock();
    }
    notifyListeners();
  }

  Future<void> _fetchWatchlist() async {
    _watchlist = await _watchlistRepository.getWatchlist();
    notifyListeners();
  }

  Future<void> _subscribeTick(String code) async {
    await _stockRepository.connect();
    _tickSubscription?.cancel();
    _tickSubscription = _stockRepository.stockTickStream(code).listen((tick) {
      final stock = _stock;
      if (stock == null) return;
      final prevPrice = stock.currentPrice;
      _stock = stock.copyWith(
        changeRate: tick.changeRate,
        priceHistory: [...stock.priceHistory, tick.currentPrice],
        updatedAt: tick.updatedAt,
      );
      _checkTargetPrice(prevPrice, tick.currentPrice);
      notifyListeners();
    });
  }

  void _checkTargetPrice(int prevPrice, int currentPrice) {
    final item = _watchlist
        .cast<WatchlistItem?>()
        .firstWhere((e) => e!.stockCode == stock.code, orElse: () => null);
    final targetPrice = item?.targetPrice;
    if (item == null || targetPrice == null) return;

    final crossedUp = prevPrice < targetPrice && currentPrice >= targetPrice;
    final crossedDown = prevPrice > targetPrice && currentPrice <= targetPrice;

    final reached = switch (item.alertType) {
      AlertType.upper => crossedUp,
      AlertType.lower => crossedDown,
      AlertType.both => crossedUp || crossedDown,
    };

    if (reached) _triggeredAlert = (item: item, isUpper: crossedUp);
  }
}
