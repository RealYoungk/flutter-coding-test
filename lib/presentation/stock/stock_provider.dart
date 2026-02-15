import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';

class StockProvider extends ChangeNotifier {
  final StockRepository _stockRepository;
  final WatchlistRepository _watchlistRepository;

  StreamSubscription<Stock>? _tickSubscription;
  Stock? _stock;

  StockProvider({
    required StockRepository stockRepository,
    required WatchlistRepository watchlistRepository,
  })  : _stockRepository = stockRepository,
        _watchlistRepository = watchlistRepository;

  void onInitialized(String code) async {
    _stock = await _stockRepository.getStock(code);
    notifyListeners();

    _tickSubscription?.cancel();
    _tickSubscription = _stockRepository.stockTickStream(code).listen((tick) {
      _stock = _stock?.copyWith(
        currentPrice: tick.currentPrice,
        changeRate: tick.changeRate,
        updatedAt: tick.updatedAt,
      );
      notifyListeners();
    });
  }

  bool get isLoading => _stock == null;
  Stock get stock => _stock ?? const Stock();

  List<String> get sectionTitles => const ['가격', '요약', '입력', '확장 패널', '기타'];

  StockRepository get stockRepository => _stockRepository;
  WatchlistRepository get watchlistRepository => _watchlistRepository;

  @override
  void dispose() {
    _tickSubscription?.cancel();
    super.dispose();
  }
}
