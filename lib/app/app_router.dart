import 'package:go_router/go_router.dart';

import 'package:flutter_bloc_template/presentation/example/example_screen.dart';
import 'package:flutter_bloc_template/presentation/feature_catalog/feature_catalog_screen.dart';
import 'package:flutter_bloc_template/presentation/root/app_shell_screen.dart';
import 'package:flutter_bloc_template/presentation/settings/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ExampleScreen.path,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) => AppShellScreen(child: child),
        routes: <RouteBase>[
          GoRoute(
            path: ExampleScreen.path,
            name: ExampleScreen.id,
            builder: (context, state) => const ExampleScreen(),
          ),
          GoRoute(
            path: FeatureCatalogScreen.path,
            name: FeatureCatalogScreen.id,
            builder: (context, state) => const FeatureCatalogScreen(),
          ),
          GoRoute(
            path: SettingsScreen.path,
            name: SettingsScreen.id,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
