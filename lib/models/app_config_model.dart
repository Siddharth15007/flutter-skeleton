class AppConfigModel {
  final String appName;
  final String flavor;
  final String baseUrl;
  final bool enableLogs;

  const AppConfigModel({
    required this.appName,
    required this.flavor,
    required this.baseUrl,
    required this.enableLogs,
  });
}
