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

    final provider = useMemoized(
      () => StockProvider(
        stockRepository: getIt<StockRepository>(),
        watchlistRepository: getIt<WatchlistRepository>(),
        toggleWatchlistUseCase: getIt<ToggleWatchlistUseCase>(),
        checkTargetPriceUseCase: getIt<CheckTargetPriceUseCase>(),
      )..onInitialized(stockCode),
    );

    useEffect(() => provider.dispose, [provider]);

    useEffect(() {
      void onAlert() {
        final alert = provider.state.triggeredAlert;
        if (alert == null) return;
        provider.clearAlert();
        final direction = alert.isUpper ? '상한 돌파' : '하한 돌파';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  '${alert.item.stockCode} 목표가 ${alert.item.targetPrice}원 $direction',
                ),
              ),
            );
        });
      }

      provider.addListener(onAlert);
      return () => provider.removeListener(onAlert);
    }, [provider]);

    return ChangeNotifierProvider.value(
      value: provider,
      child: StockView(tabScrollController: tabScrollController),
    );
  }
}
