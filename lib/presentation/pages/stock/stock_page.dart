import 'package:flutter/material.dart';
import 'package:flutter_coding_test/core/di/injection.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/check_target_price_use_case.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/hooks/use_tab_scroll_controller.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class StockPage extends HookWidget {
  const StockPage({super.key, required this.stockCode});

  final String stockCode;

  static const tabViewTitles = ['가격', '요약', '입력', '확장 패널', '기타'];

  @override
  Widget build(BuildContext context) {
    final tabScrollController = useTabScrollController(
      tabViewCount: tabViewTitles.length,
    );

    return ChangeNotifierProvider(
      create: (_) => StockProvider(
        stockRepository: getIt<StockRepository>(),
        watchlistRepository: getIt<WatchlistRepository>(),
        toggleWatchlistUseCase: getIt<ToggleWatchlistUseCase>(),
        checkTargetPriceUseCase: getIt<CheckTargetPriceUseCase>(),
      )..onInitialized(stockCode),
      child: StockView(tabScrollController: tabScrollController),
    );
  }
}
