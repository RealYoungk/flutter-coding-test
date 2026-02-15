import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // TODO(youngjin.kim): Crashlytics 등 에러 리포팅
  };

  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
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
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
