import 'package:flutter_bloc_template/models/auth_session_model.dart';
import 'package:flutter_bloc_template/register_module.dart';
import 'package:flutter_bloc_template/repositories/local_repository/secured_storage.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/auth_repository.dart';
import 'package:flutter_bloc_template/utils/result.dart';

class AuthService {
  final AuthRepository _authRepository;
  final SecuredStorage _securedStorage;
  final AppLogger _logger;

  AuthService(
    this._authRepository,
    this._securedStorage,
    this._logger,
  );

  Future<KResult<AuthSessionModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    final failure = result.fold(
      (error) => error,
      (_) => null,
    );

    if (failure != null) {
      return KResult<AuthSessionModel>.error(failure);
    }

    final session = result.fold(
      (_) => throw StateError('Session expected after failure guard.'),
      (value) => value,
    );
    final tokenResult = await _securedStorage.saveToken(session.accessToken);

    return tokenResult.fold(
      KResult<AuthSessionModel>.error,
      (_) {
        _logger.info('User authenticated: ${session.userName}');
        return KResult<AuthSessionModel>.value(session);
      },
    );
  }

  Future<KResult<void>> logout() async {
    final result = await _authRepository.logout();
    final failure = result.fold(
      (error) => error,
      (_) => null,
    );

    if (failure != null) {
      return KResult<void>.error(failure);
    }

    final clearResult = await _securedStorage.clearToken();
    return clearResult.fold(
      KResult<void>.error,
      (_) => const KResult<void>.value(null),
    );
  }
}
