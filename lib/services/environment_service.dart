import 'package:flutter_bloc_template/app/app_flavor.dart';
import 'package:flutter_bloc_template/models/app_config_model.dart';

class EnvironmentService {
  const EnvironmentService();

  AppConfigModel get currentConfig {
    const flavor = AppFlavor.current;
    return AppConfigModel(
      appName: flavor.appName,
      flavor: flavor.name,
      baseUrl: flavor.baseUrl,
      enableLogs: flavor.enableLogs,
    );
  }
}
