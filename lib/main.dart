import 'package:flutter/material.dart';

import 'package:flutter_bloc_template/app/app.dart';
import 'package:flutter_bloc_template/configure.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
