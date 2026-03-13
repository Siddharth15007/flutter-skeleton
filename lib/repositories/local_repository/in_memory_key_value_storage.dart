import 'package:flutter_bloc_template/models/failure.dart';
import 'package:flutter_bloc_template/repositories/local_repository/key_value_storage.dart';
import 'package:flutter_bloc_template/utils/result.dart';

class InMemoryKeyValueStorage extends KeyValueStorage {
  final Map<String, String> _data = <String, String>{};

  @override
  Future<KResult<void>> delete(String key) async {
    _data.remove(key);
    return const KResult<void>.value(null);
  }

  @override
  Future<KResult<String>> read(String key) async {
    final value = _data[key];
    if (value == null) {
      return const KResult<String>.error(
        StorageFailure(error: 'Requested key is not available.'),
      );
    }

    return KResult<String>.value(value);
  }

  @override
  Future<KResult<void>> write({
    required String key,
    required String value,
  }) async {
    _data[key] = value;
    return const KResult<void>.value(null);
  }
}
