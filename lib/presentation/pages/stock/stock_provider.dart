import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';

class StockProvider extends ChangeNotifier {
  StockProvider({
    required StockRepository stockRepository,
    required WatchlistRepository watchlistRepository,
  }) : _stockRepository = stockRepository,
       _watchlistRepository = watchlistRepository;

  final StockRepository _stockRepository;
  final WatchlistRepository _watchlistRepository;

  StreamSubscription<Stock>? _tickSubscription;
  Stock? _stock;

  bool get isLoading => _stock == null;

  bool get hasError => _stock != null && _stock!.code.isEmpty;

  Stock get stock => _stock ?? const Stock();

  void onInitialized(String code) async {
    await _fetchStock(code);
    if (hasError) return;
    await _subscribeTick(code);
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

  Future<void> _subscribeTick(String code) async {
    await _stockRepository.connect();
    _tickSubscription?.cancel();
    _tickSubscription = _stockRepository.stockTickStream(code).listen((tick) {
      final stock = _stock;
      if (stock == null) return;
      _stock = stock.copyWith(
        changeRate: tick.changeRate,
        priceHistory: [...stock.priceHistory, tick.currentPrice],
        updatedAt: tick.updatedAt,
      );
      notifyListeners();
    });
  }
}
