import 'package:flutter/material.dart';

import 'package:flutter_bloc_template/app/app_flavor.dart';
import 'package:flutter_bloc_template/app/app_router.dart';
import 'package:flutter_bloc_template/app/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppFlavor.current.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
    );
  }
}
