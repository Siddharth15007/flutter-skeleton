import 'package:flutter_bloc_template/utils/result.dart';

abstract class SecuredStorage {
  Future<KResult<void>> saveToken(String token);
  Future<KResult<String>> readToken();
  Future<KResult<void>> clearToken();
}
