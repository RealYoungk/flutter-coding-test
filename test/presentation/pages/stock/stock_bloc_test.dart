import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_bloc.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_event.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStockRepository extends Mock implements StockRepository {}

class _MockWatchlistRepository extends Mock implements WatchlistRepository {}

class _MockToggleWatchlistUseCase extends Mock
    implements ToggleWatchlistUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(const WatchlistItem());
  });

  group('초기 상태', () {
    test('초기 state는 로딩 상태여야 한다', () {
      final mockStockRepository = _MockStockRepository();
      when(() => mockStockRepository.disconnect()).thenReturn(null);

      final bloc = StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: _MockWatchlistRepository(),
        toggleWatchlistUseCase: _MockToggleWatchlistUseCase(),
      );

      expect(bloc.state.isLoading, true);
      expect(bloc.state.stock, const Stock());

      bloc.close();
    });
  });

  group('StockInitialized', () {
    late _MockStockRepository mockStockRepository;
    late _MockWatchlistRepository mockWatchlistRepository;
    late _MockToggleWatchlistUseCase mockToggleWatchlistUseCase;

    const testStock = Stock(
      code: '005930',
      name: '삼성전자',
      priceHistory: [72500],
      changeRate: 1.25,
    );

    setUp(() {
      mockStockRepository = _MockStockRepository();
      mockWatchlistRepository = _MockWatchlistRepository();
      mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      when(() => mockStockRepository.disconnect()).thenReturn(null);
    });

    blocTest<StockBloc, StockState>(
      '종목 조회 성공 시 state에 종목 데이터가 설정되어야 한다',
      setUp: () {
        when(
          () => mockStockRepository.getStock(any()),
        ).thenAnswer((_) async => testStock);
        when(
          () => mockWatchlistRepository.getWatchlist(),
        ).thenAnswer((_) async => []);
        when(() => mockStockRepository.connect()).thenAnswer((_) async {});
        when(
          () => mockStockRepository.stockTickStream(any()),
        ).thenAnswer((_) => const Stream.empty());
      },
      build: () => StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
      ),
      act: (bloc) => bloc.add(const StockInitialized(stockCode: '005930')),
      expect: () => [
        const StockState(stock: testStock, isLoading: false),
      ],
    );

    blocTest<StockBloc, StockState>(
      '종목 조회 실패 시 hasError가 true여야 한다',
      setUp: () {
        when(
          () => mockStockRepository.getStock(any()),
        ).thenThrow(Exception('Network error'));
      },
      build: () => StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
      ),
      act: (bloc) => bloc.add(const StockInitialized(stockCode: '005930')),
      expect: () => [const StockState(stock: Stock(), isLoading: false)],
      errors: () => [isA<Exception>()],
      verify: (_) {
        verifyNever(() => mockStockRepository.connect());
      },
    );

    blocTest<StockBloc, StockState>(
      '종목 조회 후 관심종목 목록을 로드해야 한다',
      setUp: () {
        when(
          () => mockStockRepository.getStock(any()),
        ).thenAnswer((_) async => testStock);
        when(
          () => mockWatchlistRepository.getWatchlist(),
        ).thenAnswer((_) async => []);
        when(() => mockStockRepository.connect()).thenAnswer((_) async {});
        when(
          () => mockStockRepository.stockTickStream(any()),
        ).thenAnswer((_) => const Stream.empty());
      },
      build: () => StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
      ),
      act: (bloc) => bloc.add(const StockInitialized(stockCode: '005930')),
      verify: (_) {
        verify(() => mockWatchlistRepository.getWatchlist()).called(1);
      },
    );
  });

  group('StockWatchlistAdded', () {
    late _MockStockRepository mockStockRepository;
    late _MockWatchlistRepository mockWatchlistRepository;
    late _MockToggleWatchlistUseCase mockToggleWatchlistUseCase;

    setUp(() {
      mockStockRepository = _MockStockRepository();
      mockWatchlistRepository = _MockWatchlistRepository();
      mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      when(() => mockStockRepository.disconnect()).thenReturn(null);
    });

    blocTest<StockBloc, StockState>(
      '관심종목에 추가해야 한다',
      seed: () => const StockState(
        stock: Stock(code: '005930', name: '삼성전자', priceHistory: [72500]),
        isLoading: false,
      ),
      setUp: () {
        when(
          () => mockToggleWatchlistUseCase.call(
            item: any(named: 'item'),
            isInWatchlist: any(named: 'isInWatchlist'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockWatchlistRepository.getWatchlist(),
        ).thenAnswer((_) async => []);
      },
      build: () => StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
      ),
      act: (bloc) => bloc.add(
        const StockWatchlistAdded(
          stockCode: '005930',
          targetPrice: 80000,
          alertType: AlertType.both,
        ),
      ),
      verify: (_) {
        verify(
          () => mockToggleWatchlistUseCase.call(
            item: any(named: 'item'),
            isInWatchlist: false,
          ),
        ).called(1);
      },
    );
  });

  group('StockFavoriteToggled', () {
    late _MockStockRepository mockStockRepository;
    late _MockWatchlistRepository mockWatchlistRepository;
    late _MockToggleWatchlistUseCase mockToggleWatchlistUseCase;

    setUp(() {
      mockStockRepository = _MockStockRepository();
      mockWatchlistRepository = _MockWatchlistRepository();
      mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      when(() => mockStockRepository.disconnect()).thenReturn(null);
    });

    blocTest<StockBloc, StockState>(
      '관심종목에 이미 있으면 제거해야 한다',
      seed: () => const StockState(
        stock: Stock(code: '005930', name: '삼성전자', priceHistory: [72500]),
        isLoading: false,
        watchlist: [WatchlistItem(stockCode: '005930', targetPrice: 80000)],
      ),
      setUp: () {
        when(
          () => mockToggleWatchlistUseCase.call(
            item: any(named: 'item'),
            isInWatchlist: any(named: 'isInWatchlist'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockWatchlistRepository.getWatchlist(),
        ).thenAnswer((_) async => []);
      },
      build: () => StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
      ),
      act: (bloc) => bloc.add(const StockFavoriteToggled(stockCode: '005930')),
      expect: () => [
        const StockState(
          stock: Stock(code: '005930', name: '삼성전자', priceHistory: [72500]),
          isLoading: false,
          watchlist: [],
        ),
      ],
      verify: (_) {
        verify(
          () => mockToggleWatchlistUseCase.call(
            item: any(named: 'item'),
            isInWatchlist: true,
          ),
        ).called(1);
      },
    );
  });

  group('StockTickReceived', () {
    late _MockStockRepository mockStockRepository;

    setUp(() {
      mockStockRepository = _MockStockRepository();
      when(() => mockStockRepository.disconnect()).thenReturn(null);
    });

    blocTest<StockBloc, StockState>(
      'tick 수신 시 가격 히스토리가 업데이트되어야 한다',
      seed: () => const StockState(
        stock: Stock(
          code: '005930',
          name: '삼성전자',
          priceHistory: [72500],
          changeRate: 1.25,
        ),
        isLoading: false,
      ),
      build: () => StockBloc(
        stockRepository: mockStockRepository,
        watchlistRepository: _MockWatchlistRepository(),
        toggleWatchlistUseCase: _MockToggleWatchlistUseCase(),
      ),
      act: (bloc) => bloc.add(
        const StockTickReceived(
          tick: Stock(priceHistory: [73000], changeRate: 1.50),
        ),
      ),
      verify: (bloc) {
        expect(bloc.state.stock.priceHistory, contains(73000));
        expect(bloc.state.stock.changeRate, 1.50);
      },
    );
  });
}
