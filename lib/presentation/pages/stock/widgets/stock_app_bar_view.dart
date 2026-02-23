import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_bloc.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_event.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_page.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_state.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_watchlist_dialog.dart';

class StockAppBarView extends StatelessWidget implements PreferredSizeWidget {
  const StockAppBarView({
    super.key,
    required this.tabController,
    required this.onTabTap,
  });

  final TabController tabController;
  final ValueChanged<int> onTabTap;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          BlocSelector<
            StockBloc,
            StockState,
            ({String name, String code, String logoUrl})
          >(
            selector: (state) => (
              name: state.stock.name,
              code: state.stock.code,
              logoUrl: state.stock.logoUrl,
            ),
            builder: (context, stock) => Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                  foregroundImage: stock.logoUrl.isNotEmpty
                      ? NetworkImage(stock.logoUrl)
                      : null,
                  onForegroundImageError: stock.logoUrl.isNotEmpty
                      ? (_, _) {}
                      : null,
                  child: Text(
                    stock.name.isNotEmpty ? stock.name[0] : '',
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stock.code,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
      actions: [
        BlocSelector<StockBloc, StockState,
            ({bool isInWatchlist, String code})>(
          selector: (state) =>
              (isInWatchlist: state.isInWatchlist, code: state.stock.code),
          builder: (context, data) => IconButton(
            icon: Icon(
              data.isInWatchlist ? Icons.favorite : Icons.favorite_border,
              color: data.isInWatchlist ? Colors.red : null,
            ),
            onPressed: () async {
              final bloc = context.read<StockBloc>();
              if (data.isInWatchlist) {
                bloc.add(StockFavoriteToggled(stockCode: data.code));
                return;
              }
              final result =
                  await showDialog<({int targetPrice, AlertType alertType})>(
                context: context,
                builder: (_) => const StockWatchlistDialog(),
              );
              if (result == null) return;
              bloc.add(StockWatchlistAdded(
                stockCode: data.code,
                targetPrice: result.targetPrice,
                alertType: result.alertType,
              ));
            },
          ),
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: StockPage.tabViewTitles.map((title) => Tab(text: title)).toList(),
        onTap: onTabTap,
      ),
    );
  }
}
