import 'package:flutter_bloc_template/utils/result.dart';

abstract class KeyValueStorage {
  Future<KResult<void>> write({
    required String key,
    required String value,
  });

  Future<KResult<String>> read(String key);
  Future<KResult<void>> delete(String key);
}
