import 'package:flutter_bloc_template/models/failure.dart';
import 'package:flutter_bloc_template/repositories/local_repository/secured_storage.dart';
import 'package:flutter_bloc_template/utils/constants.dart';
import 'package:flutter_bloc_template/utils/result.dart';

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
