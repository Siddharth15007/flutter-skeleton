import 'package:flutter_skeleton/models/failure.dart';
import 'package:flutter_skeleton/register_module.dart';
import 'package:flutter_skeleton/repositories/local_repository/secured_storage.dart';
import 'package:flutter_skeleton/utils/constants.dart';
import 'package:flutter_skeleton/utils/result.dart';

class SessionService {
  final SecuredStorage _securedStorage;
  final AppLogger _logger;

  SessionService(this._securedStorage, this._logger);

  Future<KResult<String>> bootstrapSession() async {
    final existingToken = await _securedStorage.readToken();
    final Failure? failure = existingToken.fold(
      (error) => error,
      (_) => null,
    );

    if (failure == null) {
      return existingToken.fold(
        KResult<String>.error,
        KResult<String>.value,
      );
    }

    _logger.info('No active token found. Bootstrapping demo session.');
    const demoToken = AppStrings.demoToken;
    final saveResult = await _securedStorage.saveToken(demoToken);

    return saveResult.fold(
      KResult<String>.error,
      (_) => const KResult<String>.value(demoToken),
    );
  }

  Future<KResult<void>> resetSession() async {
    final result = await _securedStorage.clearToken();
    return result.fold(
      (failure) => KResult<void>.error(
        StorageFailure(error: failure.message),
      ),
      (_) => const KResult<void>.value(null),
    );
  }
}
