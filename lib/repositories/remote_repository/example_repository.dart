import 'dart:async';

import 'package:flutter_bloc_template/models/example_summary_model.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/api_client.dart';
import 'package:flutter_bloc_template/utils/result.dart';

abstract class ExampleRepository {
  Future<KResult<ExampleSummaryModel>> fetchSummary();
}

class MockExampleRepository extends ExampleRepository {
  final ApiClient _apiClient;

  MockExampleRepository(this._apiClient);

  @override
  Future<KResult<ExampleSummaryModel>> fetchSummary() async {
    final result = await _apiClient.get('/template/summary');
    return result.fold(
      KResult<ExampleSummaryModel>.error,
      (payload) => KResult<ExampleSummaryModel>.value(
        ExampleSummaryModel(
          title: payload['title'] as String,
          description: payload['description'] as String,
          highlights: (payload['highlights'] as List<dynamic>)
              .map((item) => item as String)
              .toList(),
        ),
      ),
    );
  }
}
