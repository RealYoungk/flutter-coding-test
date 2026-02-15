import 'dart:async';

import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/usecases/check_target_price_use_case.dart';
import 'package:flutter_coding_test/domain/usecases/toggle_watchlist_use_case.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStockRepository extends Mock implements StockRepository {}

class _MockWatchlistRepository extends Mock implements WatchlistRepository {}

class _MockToggleWatchlistUseCase extends Mock
    implements ToggleWatchlistUseCase {}

class _MockCheckTargetPriceUseCase extends Mock
    implements CheckTargetPriceUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(const WatchlistItem());
  });

  group('초기 상태', () {
    test('초기 state는 로딩 상태여야 한다', () {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      expect(provider.state.isLoading, true);
      expect(provider.state.stock, null);

      provider.dispose();
    });
  });

  group('onInitialized', () {
    test('종목 조회 성공 시 state에 종목 데이터가 설정되어야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      const testStock = Stock(
        code: '005930',
        name: '삼성전자',
        priceHistory: [72500],
        changeRate: 1.25,
      );

      when(() => mockStockRepository.getStock(any())).thenAnswer(
        (_) async => testStock,
      );
      when(() => mockWatchlistRepository.getWatchlist()).thenAnswer(
        (_) async => [],
      );
      when(() => mockStockRepository.connect()).thenAnswer((_) async {});
      when(() => mockStockRepository.stockTickStream(any())).thenAnswer(
        (_) => const Stream.empty(),
      );

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      await provider.onInitialized('005930');

      expect(provider.state.stock, testStock);
      expect(provider.state.hasError, false);

      provider.dispose();
    });

    test('종목 조회 실패 시 hasError가 true여야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      when(() => mockStockRepository.getStock(any())).thenThrow(
        Exception('Network error'),
      );

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      await provider.onInitialized('005930');

      expect(provider.state.hasError, true);
      verifyNever(() => mockStockRepository.connect());

      provider.dispose();
    });

    test('종목 조회 후 관심종목 목록을 로드해야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      const testStock = Stock(
        code: '005930',
        name: '삼성전자',
        priceHistory: [72500],
      );

      when(() => mockStockRepository.getStock(any())).thenAnswer(
        (_) async => testStock,
      );
      when(() => mockWatchlistRepository.getWatchlist()).thenAnswer(
        (_) async => [],
      );
      when(() => mockStockRepository.connect()).thenAnswer((_) async {});
      when(() => mockStockRepository.stockTickStream(any())).thenAnswer(
        (_) => const Stream.empty(),
      );

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      await provider.onInitialized('005930');

      verify(() => mockWatchlistRepository.getWatchlist()).called(1);

      provider.dispose();
    });
  });

  group('onFavoriteToggled', () {
    test('관심종목에 없는 항목은 추가해야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      const testStock = Stock(
        code: '005930',
        name: '삼성전자',
        priceHistory: [72500],
      );

      const testItem = WatchlistItem(
        stockCode: '005930',
        targetPrice: 80000,
      );

      when(() => mockStockRepository.getStock(any())).thenAnswer(
        (_) async => testStock,
      );
      when(() => mockWatchlistRepository.getWatchlist()).thenAnswer(
        (_) async => [],
      );
      when(() => mockStockRepository.connect()).thenAnswer((_) async {});
      when(() => mockStockRepository.stockTickStream(any())).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(
        () => mockToggleWatchlistUseCase.call(
          item: any(named: 'item'),
          isInWatchlist: any(named: 'isInWatchlist'),
        ),
      ).thenAnswer((_) async {});

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      await provider.onInitialized('005930');
      await provider.onFavoriteToggled(testItem);

      verify(
        () => mockToggleWatchlistUseCase.call(
          item: testItem,
          isInWatchlist: false,
        ),
      ).called(1);

      provider.dispose();
    });

    test('관심종목에 있는 항목은 제거해야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      const testStock = Stock(
        code: '005930',
        name: '삼성전자',
        priceHistory: [72500],
      );

      const testItem = WatchlistItem(
        stockCode: '005930',
        targetPrice: 80000,
      );

      when(() => mockStockRepository.getStock(any())).thenAnswer(
        (_) async => testStock,
      );
      when(() => mockWatchlistRepository.getWatchlist()).thenAnswer(
        (_) async => [testItem],
      );
      when(() => mockStockRepository.connect()).thenAnswer((_) async {});
      when(() => mockStockRepository.stockTickStream(any())).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(
        () => mockToggleWatchlistUseCase.call(
          item: any(named: 'item'),
          isInWatchlist: any(named: 'isInWatchlist'),
        ),
      ).thenAnswer((_) async {});

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      await provider.onInitialized('005930');
      await provider.onFavoriteToggled(testItem);

      verify(
        () => mockToggleWatchlistUseCase.call(
          item: testItem,
          isInWatchlist: true,
        ),
      ).called(1);

      provider.dispose();
    });
  });

  group('clearAlert', () {
    test('triggeredAlert를 null로 초기화해야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      provider.clearAlert();

      expect(provider.state.triggeredAlert, null);

      provider.dispose();
    });

    test('notifyListeners를 호출해야 한다', () {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      var notified = false;
      provider.addListener(() {
        notified = true;
      });

      provider.clearAlert();

      expect(notified, true);

      provider.dispose();
    });
  });

  group('tick 수신', () {
    test('tick 수신 시 가격 히스토리가 업데이트되어야 한다', () async {
      final mockStockRepository = _MockStockRepository();
      final mockWatchlistRepository = _MockWatchlistRepository();
      final mockToggleWatchlistUseCase = _MockToggleWatchlistUseCase();
      final mockCheckTargetPriceUseCase = _MockCheckTargetPriceUseCase();

      const testStock = Stock(
        code: '005930',
        name: '삼성전자',
        priceHistory: [72500],
        changeRate: 1.25,
      );

      final tickController = StreamController<Stock>();
      final tickStock = testStock.copyWith(
        priceHistory: [72500, 73000],
        changeRate: 1.50,
      );

      when(() => mockStockRepository.getStock(any())).thenAnswer(
        (_) async => testStock,
      );
      when(() => mockWatchlistRepository.getWatchlist()).thenAnswer(
        (_) async => [],
      );
      when(() => mockStockRepository.connect()).thenAnswer((_) async {});
      when(() => mockStockRepository.stockTickStream(any())).thenAnswer(
        (_) => tickController.stream,
      );
      when(
        () => mockCheckTargetPriceUseCase.call(
          stockCode: any(named: 'stockCode'),
          prevPrice: any(named: 'prevPrice'),
          currentPrice: any(named: 'currentPrice'),
        ),
      ).thenAnswer((_) async => null);

      final provider = StockProvider(
        stockRepository: mockStockRepository,
        watchlistRepository: mockWatchlistRepository,
        toggleWatchlistUseCase: mockToggleWatchlistUseCase,
        checkTargetPriceUseCase: mockCheckTargetPriceUseCase,
      );

      await provider.onInitialized('005930');

      // Tick 이벤트 발생
      tickController.add(tickStock);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(provider.state.stock?.priceHistory, contains(73000));
      expect(provider.state.stock?.changeRate, 1.50);

      await tickController.close();
      provider.dispose();
    });
  });
}
