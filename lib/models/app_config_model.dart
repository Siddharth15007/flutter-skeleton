class AppConfigModel {
  final String appName;
  final String environment;
  final String baseUrl;
  final bool enableLogs;

  const AppConfigModel({
    required this.appName,
    required this.environment,
    required this.baseUrl,
    required this.enableLogs,
  });
}
