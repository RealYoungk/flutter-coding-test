import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coding_test/core/di/injection.dart';
import 'package:flutter_coding_test/hive_registrar.g.dart';
import 'package:flutter_coding_test/presentation/pages/stock/stock_page.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // TODO(youngjin.kim): Crashlytics 등 에러 리포팅
  };

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Hive.initFlutter();
      Hive.registerAdapters();

      await initDependencies();
      runApp(const MainApp());
    },
    (error, stackTrace) {
      // TODO(youngjin.kim): Crashlytics 등 에러 리포팅
      debugPrint('Uncaught error: $error');
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StockPage(stockCode: '005930'),
    );
  }
}
