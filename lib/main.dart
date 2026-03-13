import 'package:flutter/material.dart';

import 'package:flutter_skeleton/app/app.dart';
import 'package:flutter_skeleton/configure.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
