import 'package:flutter_coding_test/data/ezar/ezar.dart';
import 'package:flutter_coding_test/data/local/local.dart';
import 'package:flutter_coding_test/data/repositories/stock_repository_impl.dart';
import 'package:flutter_coding_test/data/repositories/watchlist_repository_impl.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/check_target_price_use_case.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // DataSources
  getIt.registerSingleton(await WatchlistDataSourceLocal.init());
  getIt.registerSingleton(StockDataSourceEzar());
  getIt.registerSingleton(StockTickDataSourceEzar());

  // Repositories
  getIt.registerSingleton<WatchlistRepository>(
    WatchlistRepositoryImpl(getIt<WatchlistDataSourceLocal>()),
  );
  getIt.registerSingleton<StockRepository>(
    StockRepositoryImpl(getIt<StockDataSourceEzar>(), getIt<StockTickDataSourceEzar>()),
  );

  // UseCases
  getIt.registerFactory(() => ToggleWatchlistUseCase(getIt<WatchlistRepository>()));
  getIt.registerFactory(() => CheckTargetPriceUseCase(getIt<WatchlistRepository>()));
}
