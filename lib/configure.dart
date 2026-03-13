import 'package:get_it/get_it.dart';

import 'package:flutter_bloc_template/register_module.dart';
import 'package:flutter_bloc_template/repositories/local_repository/in_memory_secured_storage.dart';
import 'package:flutter_bloc_template/repositories/local_repository/secured_storage.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/example_repository.dart';
import 'package:flutter_bloc_template/services/example_service.dart';
import 'package:flutter_bloc_template/services/session_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<RegisterModule>()) {
    return;
  }

  final registerModule = RegisterModule();
  getIt.registerSingleton<RegisterModule>(registerModule);
  getIt.registerLazySingleton<AppLogger>(() => registerModule.logger);
  getIt.registerLazySingleton<SecuredStorage>(
    InMemorySecuredStorage.new,
  );
  getIt.registerLazySingleton<ExampleRepository>(
    MockExampleRepository.new,
  );
  getIt.registerLazySingleton<SessionService>(
    () => SessionService(
      getIt<SecuredStorage>(),
      getIt<AppLogger>(),
    ),
  );
  getIt.registerLazySingleton<ExampleService>(
    () => ExampleService(
      getIt<ExampleRepository>(),
      getIt<SessionService>(),
      getIt<AppLogger>(),
    ),
  );
}
