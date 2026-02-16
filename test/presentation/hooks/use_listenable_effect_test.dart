import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_test/presentation/hooks/use_listenable_effect.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('useListenableEffect', () {
    testWidgets('값이 변경되면 effect가 호출되어야 한다', (tester) async {
      final notifier = ValueNotifier(0);
      final effects = <int>[];

      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            useListenableEffect(
              notifier,
              () => notifier.value,
              (value) => effects.add(value),
            );
            return const SizedBox();
          },
        ),
      );

      expect(effects, isEmpty);

      notifier.value = 1;
      expect(effects, [1]);

      notifier.value = 2;
      expect(effects, [1, 2]);

      notifier.dispose();
    });

    testWidgets('값이 변경되지 않으면 effect가 호출되지 않아야 한다', (tester) async {
      final notifier = ValueNotifier(0);
      final effects = <int>[];

      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            useListenableEffect(
              notifier,
              () => notifier.value,
              (value) => effects.add(value),
            );
            return const SizedBox();
          },
        ),
      );

      notifier.notifyListeners();
      expect(effects, isEmpty);

      notifier.dispose();
    });

    testWidgets('위젯이 dispose되면 리스너가 해제되어야 한다', (tester) async {
      final notifier = ValueNotifier(0);
      final effects = <int>[];

      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            useListenableEffect(
              notifier,
              () => notifier.value,
              (value) => effects.add(value),
            );
            return const SizedBox();
          },
        ),
      );

      await tester.pumpWidget(const SizedBox());

      notifier.value = 1;
      expect(effects, isEmpty);

      notifier.dispose();
    });

    testWidgets('null 값 변경도 감지해야 한다', (tester) async {
      final notifier = ValueNotifier<int?>(null);
      final effects = <int?>[];

      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            useListenableEffect(
              notifier,
              () => notifier.value,
              (value) => effects.add(value),
            );
            return const SizedBox();
          },
        ),
      );

      notifier.value = 42;
      expect(effects, [42]);

      notifier.value = null;
      expect(effects, [42, null]);

      notifier.dispose();
    });

    testWidgets('ChangeNotifier에서도 동작해야 한다', (tester) async {
      final counter = _Counter();
      final effects = <int>[];

      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            useListenableEffect(
              counter,
              () => counter.count,
              (value) => effects.add(value),
            );
            return const SizedBox();
          },
        ),
      );

      counter.increment();
      expect(effects, [1]);

      counter.increment();
      expect(effects, [1, 2]);

      counter.dispose();
    });
  });
}

class _Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
