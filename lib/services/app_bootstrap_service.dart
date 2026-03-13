import 'package:flutter_bloc_template/app/app_flavor.dart';
import 'package:flutter_bloc_template/models/app_config_model.dart';
import 'package:flutter_bloc_template/register_module.dart';
import 'package:flutter_bloc_template/repositories/local_repository/key_value_storage.dart';
import 'package:flutter_bloc_template/services/environment_service.dart';
import 'package:flutter_bloc_template/services/session_service.dart';
import 'package:flutter_bloc_template/utils/constants.dart';
import 'package:flutter_bloc_template/utils/result.dart';

class AppBootstrapPayload {
  final AppConfigModel config;
  final String sessionToken;

  const AppBootstrapPayload({
    required this.config,
    required this.sessionToken,
  });
}

class AppBootstrapService {
  final SessionService _sessionService;
  final KeyValueStorage _keyValueStorage;
  final EnvironmentService _environmentService;
  final AppLogger _logger;

  AppBootstrapService(
    this._sessionService,
    this._keyValueStorage,
    this._environmentService,
    this._logger,
  );

  Future<KResult<AppBootstrapPayload>> bootstrap() async {
    final config = _environmentService.currentConfig;

    final cacheResult = await _keyValueStorage.write(
      key: StorageKeys.flavor,
      value: config.flavor,
    );

    final cacheFailure = cacheResult.fold(
      (failure) => failure,
      (_) => null,
    );

    if (cacheFailure != null) {
      return KResult<AppBootstrapPayload>.error(cacheFailure);
    }

    final sessionResult = await _sessionService.bootstrapSession();
    return sessionResult.fold(
      KResult<AppBootstrapPayload>.error,
      (token) {
        _logger.info(
          'Application bootstrap finished for ${AppFlavor.current.name}.',
        );
        return KResult<AppBootstrapPayload>.value(
          AppBootstrapPayload(
            config: config,
            sessionToken: token,
          ),
        );
      },
    );
  }
}
