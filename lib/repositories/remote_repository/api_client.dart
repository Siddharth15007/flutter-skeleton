import 'dart:async';

import 'package:flutter_bloc_template/models/failure.dart';
import 'package:flutter_bloc_template/utils/result.dart';

abstract class ApiClient {
  Future<KResult<Map<String, dynamic>>> get(String path);
  Future<KResult<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? body,
  });
}

class MockApiClient extends ApiClient {
  @override
  Future<KResult<Map<String, dynamic>>> get(String path) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    if (path == '/template/summary') {
      return const KResult<Map<String, dynamic>>.value(
        <String, dynamic>{
          'title': 'Reusable Template Project',
          'description':
              'A premium Flutter template with app bootstrap, shell navigation, and layered architecture.',
          'highlights': <String>[
            'App shell with route scaffolding',
            'Repository and service boundaries',
            'Secure storage and config placeholders',
          ],
        },
      );
    }

    return const KResult<Map<String, dynamic>>.error(
      ValidationFailure(error: 'Unsupported mock endpoint.'),
    );
  }

  @override
  Future<KResult<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return KResult<Map<String, dynamic>>.value(
      <String, dynamic>{
        'path': path,
        'body': body ?? <String, dynamic>{},
        'status': 'ok',
      },
    );
  }
}
