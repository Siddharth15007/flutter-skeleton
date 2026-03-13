import 'package:flutter/material.dart';

import 'package:flutter_skeleton/app/app_router.dart';
import 'package:flutter_skeleton/app/app_theme.dart';
import 'package:flutter_skeleton/utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
    );
  }
}
