import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useListenableEffect<T>(
  Listenable listenable,
  T Function() selector,
  void Function(T value) effect,
) {
  useEffect(() {
    T prev = selector();
    void listener() {
      final current = selector();
      if (current != prev) {
        effect(current);
        prev = current;
      }
    }

    listenable.addListener(listener);
    return () => listenable.removeListener(listener);
  }, [listenable]);
}
