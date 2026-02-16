import 'package:flutter/material.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_page.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:flutter_coding_test/presentation/pages/stock/widgets/stock_watchlist_dialog.dart';
import 'package:provider/provider.dart';

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
          Selector<StockProvider, ({String name, String code, String logoUrl})>(
            selector: (_, p) => (
              name: p.state.stock.name,
              code: p.state.stock.code,
              logoUrl: p.state.stock.logoUrl,
            ),
            builder: (context, stock, _) => Row(
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
        Selector<StockProvider, ({bool isInWatchlist, String code})>(
          selector: (_, p) =>
              (isInWatchlist: p.state.isInWatchlist, code: p.state.stock.code),
          builder: (context, data, _) => IconButton(
            icon: Icon(
              data.isInWatchlist ? Icons.favorite : Icons.favorite_border,
              color: data.isInWatchlist ? Colors.red : null,
            ),
            onPressed: () async {
              final provider = context.read<StockProvider>();
              final needsDialog = await provider.onFavoriteToggled(data.code);
              if (!needsDialog || !context.mounted) return;
              final result =
                  await showDialog<({int targetPrice, AlertType alertType})>(
                    context: context,
                    builder: (_) => const StockWatchlistDialog(),
                  );
              if (result == null) return;
              await provider.onWatchlistAdded(
                stockCode: data.code,
                targetPrice: result.targetPrice,
                alertType: result.alertType,
              );
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
