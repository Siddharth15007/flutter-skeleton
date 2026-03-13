class AppFlavor {
  final String name;
  final String appName;
  final String baseUrl;
  final bool enableLogs;

  const AppFlavor({
    required this.name,
    required this.appName,
    required this.baseUrl,
    required this.enableLogs,
  });

  static const AppFlavor current = AppFlavor(
    name: String.fromEnvironment('FLAVOR', defaultValue: 'dev'),
    appName: String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter BLoC Template Dev',
    ),
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://dev-api.example.com',
    ),
    enableLogs: bool.fromEnvironment('ENABLE_LOGS', defaultValue: true),
  );

  bool get isProduction => name == 'prod';
}
