import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_event.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({
    required StockRepository stockRepository,
    required WatchlistRepository watchlistRepository,
    required ToggleWatchlistUseCase toggleWatchlistUseCase,
  }) : _stockRepository = stockRepository,
       _watchlistRepository = watchlistRepository,
       _toggleWatchlistUseCase = toggleWatchlistUseCase,
       super(const StockState()) {
    on<StockInitialized>(_onInitialized);
    on<StockFavoriteToggled>(_onFavoriteToggled);
    on<StockWatchlistAdded>(_onWatchlistAdded);
    on<StockTickReceived>(_onTickReceived);
  }

  final StockRepository _stockRepository;
  final WatchlistRepository _watchlistRepository;
  final ToggleWatchlistUseCase _toggleWatchlistUseCase;

  StreamSubscription<Stock>? _tickSubscription;

  Future<void> _onInitialized(
    StockInitialized event,
    Emitter<StockState> emit,
  ) async {
    await _fetchStock(event.stockCode, emit);
    if (state.hasError) return;
    await _fetchWatchlist(emit);
    await _subscribeTick(event.stockCode);
  }

  Future<void> _onFavoriteToggled(
    StockFavoriteToggled event,
    Emitter<StockState> emit,
  ) async {
    await _toggleWatchlistUseCase(
      item: WatchlistItem(stockCode: event.stockCode),
      isInWatchlist: true,
    );
    await _fetchWatchlist(emit);
  }

  Future<void> _onWatchlistAdded(
    StockWatchlistAdded event,
    Emitter<StockState> emit,
  ) async {
    await _toggleWatchlistUseCase(
      item: WatchlistItem(
        stockCode: event.stockCode,
        targetPrice: event.targetPrice,
        alertType: event.alertType,
        createdAt: DateTime.now(),
      ),
      isInWatchlist: false,
    );
    await _fetchWatchlist(emit);
  }

  void _onTickReceived(
    StockTickReceived event,
    Emitter<StockState> emit,
  ) {
    final stock = state.stock;
    emit(
      state.copyWith(
        stock: stock.copyWith(
          changeRate: event.tick.changeRate,
          priceHistory: [...stock.priceHistory, event.tick.currentPrice],
          updatedAt: event.tick.updatedAt,
        ),
      ),
    );
  }

  Future<void> _fetchStock(String code, Emitter<StockState> emit) async {
    try {
      emit(
        state.copyWith(
          stock: await _stockRepository.getStock(code),
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(stock: const Stock(), isLoading: false));
      rethrow;
    }
  }

  Future<void> _fetchWatchlist(Emitter<StockState> emit) async {
    emit(state.copyWith(watchlist: await _watchlistRepository.getWatchlist()));
  }

  Future<void> _subscribeTick(String code) async {
    await _stockRepository.connect();
    _tickSubscription?.cancel();
    _tickSubscription = _stockRepository
        .stockTickStream(code)
        .listen(
          (tick) {
            add(StockTickReceived(tick: tick));
          },
          onError: (Object error, StackTrace stackTrace) {
            _tickSubscription?.cancel();
            _stockRepository.disconnect();
            _reconnectTick(code);
            Error.throwWithStackTrace(error, stackTrace);
          },
        );
  }

  void _reconnectTick(String code) {
    Future.delayed(const Duration(seconds: 5), () {
      if (isClosed) return;
      _subscribeTick(code);
    });
  }

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    _stockRepository.disconnect();
    return super.close();
  }
}
