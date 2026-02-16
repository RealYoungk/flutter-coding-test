import 'package:flutter/material.dart';
import 'package:flutter_coding_test/domain/watchlist/watchlist.dart';

class StockWatchlistDialog extends StatefulWidget {
  const StockWatchlistDialog({super.key});

  @override
  State<StockWatchlistDialog> createState() => _StockWatchlistDialogState();
}

class _StockWatchlistDialogState extends State<StockWatchlistDialog> {
  final _priceController = TextEditingController();
  AlertType _alertType = AlertType.both;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('관심 종목 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: '목표가',
              hintText: '목표 가격을 입력하세요',
              border: OutlineInputBorder(),
              suffixText: '원',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SegmentedButton<AlertType>(
            segments: AlertType.values
                .map(
                  (type) => ButtonSegment(
                    value: type,
                    label: Text(type.label),
                  ),
                )
                .toList(),
            selected: {_alertType},
            onSelectionChanged: (selected) {
              setState(() => _alertType = selected.first);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: () {
            final price = int.tryParse(_priceController.text);
            if (price == null) return;
            Navigator.pop(context, (targetPrice: price, alertType: _alertType));
          },
          child: const Text('추가'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }
}
