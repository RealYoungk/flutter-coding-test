import 'package:flutter/material.dart';
import 'package:flutter_coding_test/domain/stock/stock.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/stock/stock_provider.dart';
import 'package:flutter_coding_test/presentation/stock/stock_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class _MockStockRepository extends Mock implements StockRepository {}
class _MockWatchlistRepository extends Mock implements WatchlistRepository {}

void main() {
  group('StockView', () {
    late _MockStockRepository mockStockRepository;
    late _MockWatchlistRepository mockWatchlistRepository;

    setUp(() {
      mockStockRepository = _MockStockRepository();
      mockWatchlistRepository = _MockWatchlistRepository();

      when(() => mockStockRepository.getStock(any<String>())).thenAnswer(
        (_) async => const Stock(
          code: '005930',
          name: '삼성전자',
          currentPrice: 72500,
          changeRate: 1.25,
        ),
      );

      when(() => mockStockRepository.stockTickStream(any<String>())).thenAnswer(
        (_) => const Stream.empty(),
      );
    });

    Future<void> pumpStockView(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => StockProvider(
              stockRepository: mockStockRepository,
              watchlistRepository: mockWatchlistRepository,
            )..onInitialized('005930'),
            child: const StockView(),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('헤더에 종목명이 표시되어야 한다', (tester) async {
      await pumpStockView(tester);

      expect(find.text('삼성전자'), findsOneWidget);
    });

    testWidgets('헤더에 종목 코드가 표시되어야 한다', (tester) async {
      await pumpStockView(tester);

      expect(find.text('005930'), findsOneWidget);
    });

    testWidgets('헤더에 종목 로고가 표시되어야 한다', (tester) async {
      await pumpStockView(tester);

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('섹션 네비게이션 탭이 표시되어야 한다', (tester) async {
      await pumpStockView(tester);

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.descendant(of: find.byType(TabBar), matching: find.text('가격')), findsOneWidget);
      expect(find.descendant(of: find.byType(TabBar), matching: find.text('요약')), findsOneWidget);
      expect(find.descendant(of: find.byType(TabBar), matching: find.text('입력')), findsOneWidget);
      expect(find.descendant(of: find.byType(TabBar), matching: find.text('확장 패널')), findsOneWidget);
      expect(find.descendant(of: find.byType(TabBar), matching: find.text('기타')), findsOneWidget);
    });

    testWidgets('현재 가격이 표시되어야 한다', (tester) async {
      await pumpStockView(tester);

      expect(find.text('72,500'), findsOneWidget);
    });

    testWidgets('변동률이 표시되어야 한다', (tester) async {
      await pumpStockView(tester);

      expect(find.text('+1.25%'), findsOneWidget);
    });
  });
}
