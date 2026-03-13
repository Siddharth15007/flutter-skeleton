import 'package:flutter/foundation.dart';

class RegisterModule {
  final AppLogger logger = const AppLogger();
}

class AppLogger {
  const AppLogger();

  void info(String message) {
    debugPrint('INFO: $message');
  }

  void error(String message) {
    debugPrint('ERROR: $message');
  }
}
