import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/check_target_price_use_case.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_state.dart';

class StockProvider extends ChangeNotifier {
  StockProvider({
    required StockRepository stockRepository,
    required WatchlistRepository watchlistRepository,
    required ToggleWatchlistUseCase toggleWatchlistUseCase,
    required CheckTargetPriceUseCase checkTargetPriceUseCase,
  })  : _stockRepository = stockRepository,
        _watchlistRepository = watchlistRepository,
        _toggleWatchlistUseCase = toggleWatchlistUseCase,
        _checkTargetPriceUseCase = checkTargetPriceUseCase;

  final StockRepository _stockRepository;
  final WatchlistRepository _watchlistRepository;
  final ToggleWatchlistUseCase _toggleWatchlistUseCase;
  final CheckTargetPriceUseCase _checkTargetPriceUseCase;

  StreamSubscription<Stock>? _tickSubscription;

  StockState _state = const StockState();
  StockState get state => _state;

  void onInitialized(String code) async {
    await _fetchStock(code);
    if (_state.hasError) return;
    await _fetchWatchlist();
    await _subscribeTick(code);
  }

  Future<void> onFavoriteToggled(WatchlistItem item) async {
    await _toggleWatchlistUseCase(item: item, isInWatchlist: _state.isInWatchlist);
    await _fetchWatchlist();
  }

  void clearAlert() {
    _state = _state.copyWith(triggeredAlert: null);
  }

  @override
  void dispose() {
    _tickSubscription?.cancel();
    _stockRepository.disconnect();
    super.dispose();
  }

  Future<void> _fetchStock(String code) async {
    try {
      _state = _state.copyWith(stock: await _stockRepository.getStock(code));
    } catch (_) {
      _state = _state.copyWith(stock: const Stock());
    }
    notifyListeners();
  }

  Future<void> _fetchWatchlist() async {
    _state = _state.copyWith(watchlist: await _watchlistRepository.getWatchlist());
    notifyListeners();
  }

  Future<void> _subscribeTick(String code) async {
    await _stockRepository.connect();
    _tickSubscription?.cancel();
    _tickSubscription = _stockRepository.stockTickStream(code).listen((tick) async {
      final stock = _state.stock;
      if (stock == null) return;
      final prevPrice = stock.currentPrice;
      _state = _state.copyWith(
        stock: stock.copyWith(
          changeRate: tick.changeRate,
          priceHistory: [...stock.priceHistory, tick.currentPrice],
          updatedAt: tick.updatedAt,
        ),
        triggeredAlert: await _checkTargetPriceUseCase(
          stockCode: stock.code,
          prevPrice: prevPrice,
          currentPrice: tick.currentPrice,
        ),
      );
      notifyListeners();
    });
  }
}
