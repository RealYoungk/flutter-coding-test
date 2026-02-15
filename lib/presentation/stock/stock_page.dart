import 'package:flutter/material.dart';
import 'package:flutter_coding_test/core/di/injection.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/stock/stock_provider.dart';
import 'package:flutter_coding_test/presentation/stock/stock_view.dart';
import 'package:provider/provider.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StockProvider(
        stockRepository: getIt<StockRepository>(),
        watchlistRepository: getIt<WatchlistRepository>(),
      ),
      child: const StockView(),
    );
  }
}
