import 'package:go_router/go_router.dart';

import 'package:flutter_skeleton/presentation/example/example_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ExampleScreen.path,
    routes: <RouteBase>[
      GoRoute(
        path: ExampleScreen.path,
        name: ExampleScreen.id,
        builder: (context, state) => const ExampleScreen(),
      ),
    ],
  );
}
