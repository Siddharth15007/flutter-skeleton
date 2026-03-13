import 'package:flutter/material.dart';

class AppStrings {
  static const String appName = 'Flutter BLoC Template';
  static const String demoToken = 'demo-token-2026-secure-seed';
}

class ErrorMessages {
  static const String internalError = 'Something went wrong.';
  static const String tokenNotFound = 'Session not available.';
  static const String invalidToken = 'Token cannot be empty.';
}

class StorageKeys {
  static const String flavor = 'flavor';
}

class AppSpacing {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
}

class AppRouteItem {
  final String label;
  final String path;
  final IconData icon;

  const AppRouteItem({
    required this.label,
    required this.path,
    required this.icon,
  });
}

class AppRoutes {
  static const List<AppRouteItem> items = <AppRouteItem>[
    AppRouteItem(label: 'Home', path: '/', icon: Icons.home_outlined),
    AppRouteItem(
      label: 'Features',
      path: '/feature-catalog',
      icon: Icons.widgets_outlined,
    ),
    AppRouteItem(
      label: 'Settings',
      path: '/settings',
      icon: Icons.settings_outlined,
    ),
  ];
}

class AppTemplateMessages {
  static const List<String> featureSteps = <String>[
    'Copy the example feature folder structure.',
    'Create model, repository, service, bloc, and screen for the new domain.',
    'Register dependencies in configure.dart.',
    'Add the route in app_router.dart.',
    'Reuse the auth or pagination templates where they fit.',
    'Write widget and service tests for the new feature.',
  ];

  static const List<String> productionChecklist = <String>[
    'Replace mock API client with Dio or your preferred client.',
    'Switch ApiClient registration from MockApiClient to DioApiClient.',
    'Use flutter_secure_storage for sensitive data.',
    'Add environment-based configuration and secrets management.',
    'Integrate analytics, crash reporting, and remote config.',
    'Add CI for analyze, test, and build workflows.',
  ];
}
