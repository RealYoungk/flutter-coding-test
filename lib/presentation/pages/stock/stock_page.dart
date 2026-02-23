import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coding_test/core/di/injection.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/hooks/use_tab_scroll_controller.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_bloc.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_event.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_state.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StockPage extends HookWidget {
  const StockPage({super.key, required this.stockCode});

  final String stockCode;

  static const tabViewTitles = ['가격', '요약', '입력', '확장 패널', '기타'];

  @override
  Widget build(BuildContext context) {
    final tabScrollController = useTabScrollController(
      tabViewCount: tabViewTitles.length,
    );

    return BlocProvider(
      create: (_) => StockBloc(
        stockRepository: getIt<StockRepository>(),
        watchlistRepository: getIt<WatchlistRepository>(),
        toggleWatchlistUseCase: getIt<ToggleWatchlistUseCase>(),
      )..add(StockInitialized(stockCode: stockCode)),
      child: BlocListener<StockBloc, StockState>(
        listenWhen: (prev, curr) =>
            prev.stock.currentPrice != curr.stock.currentPrice &&
            curr.needsTargetPriceAlert != null,
        listener: (context, state) {
          final alert = state.needsTargetPriceAlert!;
          final direction = alert.isUpper ? '상한 돌파' : '하한 돌파';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  '${alert.stockCode} 목표가 ${alert.targetPrice}원 $direction',
                ),
              ),
            );
        },
        child: StockView(tabScrollController: tabScrollController),
      ),
    );
  }
}
