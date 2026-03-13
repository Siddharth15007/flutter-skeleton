import 'package:flutter_bloc_template/models/auth_session_model.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/api_client.dart';
import 'package:flutter_bloc_template/utils/result.dart';

abstract class AuthRepository {
  Future<KResult<AuthSessionModel>> login({
    required String email,
    required String password,
  });

  Future<KResult<void>> logout();
}

class MockAuthRepository extends AuthRepository {
  final ApiClient _apiClient;

  MockAuthRepository(this._apiClient);

  @override
  Future<KResult<AuthSessionModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await _apiClient.post(
      '/auth/login',
      body: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    return result.fold(
      KResult<AuthSessionModel>.error,
      (_) => KResult<AuthSessionModel>.value(
        AuthSessionModel(
          accessToken: 'access-token-$email',
          refreshToken: 'refresh-token-$email',
          userName: email.split('@').first,
          isAuthenticated: true,
        ),
      ),
    );
  }

  @override
  Future<KResult<void>> logout() async {
    final result = await _apiClient.post('/auth/logout');
    return result.fold(
      KResult<void>.error,
      (_) => const KResult<void>.value(null),
    );
  }
}
