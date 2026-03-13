import 'package:flutter_skeleton/models/failure.dart';
import 'package:flutter_skeleton/repositories/local_repository/secured_storage.dart';
import 'package:flutter_skeleton/utils/constants.dart';
import 'package:flutter_skeleton/utils/result.dart';

class InMemorySecuredStorage extends SecuredStorage {
  String? _token;

  @override
  Future<KResult<void>> clearToken() async {
    _token = null;
    return const KResult.value(null);
  }

  @override
  Future<KResult<String>> readToken() async {
    final token = _token;
    if (token == null || token.isEmpty) {
      return const KResult.error(
        StorageFailure(error: ErrorMessages.tokenNotFound),
      );
    }
    return KResult.value(token);
  }

  @override
  Future<KResult<void>> saveToken(String token) async {
    if (token.isEmpty) {
      return const KResult.error(
        StorageFailure(error: ErrorMessages.invalidToken),
      );
    }

    _token = token;
    return const KResult.value(null);
  }
}
