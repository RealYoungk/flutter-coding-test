import 'package:flutter/material.dart';
import 'package:flutter_coding_test/presentation/hooks/use_tab_scroll_controller.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_app_bar_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_etc_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_expansion_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_input_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_price_view.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_summary_view.dart';
import 'package:provider/provider.dart';

class StockView extends StatelessWidget {
  const StockView({super.key, required this.tabScrollController});

  final TabScrollController tabScrollController;

  @override
  Widget build(BuildContext context) {
    return Selector<StockProvider, ({bool hasError, bool isLoading})>(
      selector: (_, p) =>
          (hasError: p.state.hasError, isLoading: p.state.isLoading),
      builder: (context, state, _) {
        if (state.hasError) {
          return const Scaffold(
            body: Center(child: Text('종목 정보를 불러오지 못했습니다.')),
          );
        }
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: StockAppBarView(
            tabController: tabScrollController.tabController,
            onTabTap: tabScrollController.scrollTo,
          ),
          body: ListView(
            key: tabScrollController.viewportKey,
            controller: tabScrollController.scrollController,
            children: [
              StockPriceView(key: tabScrollController.keys[0]),
              const Divider(),
              StockSummaryView(key: tabScrollController.keys[1]),
              const Divider(),
              StockInputView(key: tabScrollController.keys[2]),
              const Divider(),
              StockExpansionView(key: tabScrollController.keys[3]),
              const Divider(),
              StockEtcView(key: tabScrollController.keys[4]),
            ],
          ),
        );
      },
    );
  }
}
