import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_test/core/extensions/number_format_extension.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_provider.dart';
import 'package:provider/provider.dart';

class StockPriceView extends StatelessWidget {
  const StockPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      StockProvider,
      ({int currentPrice, double changeRate, List<int> priceHistory})
    >(
      selector: (_, p) => (
        currentPrice: p.state.stockOrDefault.currentPrice,
        changeRate: p.state.stockOrDefault.changeRate,
        priceHistory: p.state.stockOrDefault.priceHistory,
      ),
      builder: (context, stock, _) {
        final spots = stock.priceHistory
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
            .toList();
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('가격', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    stock.currentPrice.formattedPrice,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '원',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    stock.changeRate.formattedChangeRate,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: _changeRateColor(stock.changeRate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: _changeRateColor(stock.changeRate),
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: _changeRateColor(
                            stock.changeRate,
                          ).withAlpha(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _changeRateColor(double rate) {
    if (rate > 0) return Colors.red;
    if (rate < 0) return Colors.blue;
    return Colors.grey;
  }
}
