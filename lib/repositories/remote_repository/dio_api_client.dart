import 'package:dio/dio.dart';

import 'package:flutter_bloc_template/app/app_flavor.dart';
import 'package:flutter_bloc_template/models/failure.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/api_client.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/api_interceptor.dart';
import 'package:flutter_bloc_template/utils/result.dart';

class DioApiClient extends ApiClient {
  final Dio _dio;

  DioApiClient(ApiInterceptor interceptor)
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppFlavor.current.baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
          ),
        )..interceptors.add(interceptor);

  @override
  Future<KResult<Map<String, dynamic>>> get(String path) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(path);
      return KResult<Map<String, dynamic>>.value(
        response.data ?? <String, dynamic>{},
      );
    } on DioException catch (error) {
      return KResult<Map<String, dynamic>>.error(
        ValidationFailure(error: error.message ?? 'API request failed.'),
      );
    }
  }

  @override
  Future<KResult<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: body,
      );
      return KResult<Map<String, dynamic>>.value(
        response.data ?? <String, dynamic>{},
      );
    } on DioException catch (error) {
      return KResult<Map<String, dynamic>>.error(
        ValidationFailure(error: error.message ?? 'API request failed.'),
      );
    }
  }
}
