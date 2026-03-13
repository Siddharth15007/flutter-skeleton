import 'package:dio/dio.dart';

import 'package:flutter_bloc_template/app/app_flavor.dart';
import 'package:flutter_bloc_template/register_module.dart';
import 'package:flutter_bloc_template/repositories/local_repository/secured_storage.dart';

class ApiInterceptor extends Interceptor {
  final SecuredStorage _securedStorage;
  final AppLogger _logger;

  ApiInterceptor(this._securedStorage, this._logger);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenResult = await _securedStorage.readToken();
    tokenResult.fold(
      (_) => null,
      (token) {
        options.headers['Authorization'] = 'Bearer $token';
      },
    );

    options.headers['X-App-Flavor'] = AppFlavor.current.name;

    if (AppFlavor.current.enableLogs) {
      _logger.info('HTTP ${options.method} ${options.uri}');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error('HTTP ERROR ${err.requestOptions.uri}: ${err.message}');
    handler.next(err);
  }
}
