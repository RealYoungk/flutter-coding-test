import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TabScrollController {
  const TabScrollController({
    required this.tabController,
    required this.scrollController,
    required this.viewportKey,
    required this.keys,
    required this.scrollTo,
  });

  final TabController tabController;
  final ScrollController scrollController;
  final GlobalKey viewportKey;
  final List<GlobalKey> keys;
  final ValueChanged<int> scrollTo;
}

TabScrollController useTabScrollController({required int tabViewCount}) {
  final scrollController = useScrollController();
  final tabController = useTabController(initialLength: tabViewCount);
  final viewportKey = useMemoized(GlobalKey.new);
  final tabViewKeys = useMemoized(() => List.generate(tabViewCount, (_) => GlobalKey()));
  final isScrollingByTap = useRef(false);

  double getTopDyOfWidget(GlobalKey key) {
    final box = key.currentContext!.findRenderObject()! as RenderBox;
    return box.localToGlobal(Offset.zero).dy;
  }

  int findCurrentTabIndex() {
    final viewportTop = getTopDyOfWidget(viewportKey);
    return tabViewKeys.lastIndexWhere((key) {
      return key.currentContext != null && getTopDyOfWidget(key) <= viewportTop;
    });
  }

  useEffect(() {
    void onScroll() {
      if (isScrollingByTap.value) return;
      if (viewportKey.currentContext == null) return;

      final currentIndex = findCurrentTabIndex();
      if (currentIndex != -1 && tabController.index != currentIndex) {
        tabController.index = currentIndex;
      }
    }

    scrollController.addListener(onScroll);
    return () => scrollController.removeListener(onScroll);
  }, [scrollController, tabController]);

  void scrollTo(int index) {
    final targetContext = tabViewKeys[index].currentContext;
    if (targetContext == null) return;

    isScrollingByTap.value = true;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ).then((_) => isScrollingByTap.value = false);
  }

  return TabScrollController(
    tabController: tabController,
    scrollController: scrollController,
    viewportKey: viewportKey,
    keys: tabViewKeys,
    scrollTo: scrollTo,
  );
}
