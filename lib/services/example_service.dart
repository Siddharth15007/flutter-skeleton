import 'package:flutter_bloc_template/models/example_summary_model.dart';
import 'package:flutter_bloc_template/models/failure.dart';
import 'package:flutter_bloc_template/register_module.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/example_repository.dart';
import 'package:flutter_bloc_template/services/session_service.dart';
import 'package:flutter_bloc_template/utils/result.dart';

class ExamplePayload {
  final ExampleSummaryModel summary;
  final String sessionToken;

  const ExamplePayload({
    required this.summary,
    required this.sessionToken,
  });
}

class ExampleService {
  final ExampleRepository _repository;
  final SessionService _sessionService;
  final AppLogger _logger;

  ExampleService(
    this._repository,
    this._sessionService,
    this._logger,
  );

  Future<KResult<ExamplePayload>> loadExample() async {
    try {
      final summaryResult = await _repository.fetchSummary();
      final summaryFailure = summaryResult.fold(
        (failure) => failure,
        (_) => null,
      );

      if (summaryFailure != null) {
        return KResult<ExamplePayload>.error(summaryFailure);
      }

      final summary = summaryResult.fold(
        (_) => throw StateError('Summary expected after failure guard.'),
        (value) => value,
      );
      final sessionResult = await _sessionService.bootstrapSession();

      return sessionResult.fold(
        KResult<ExamplePayload>.error,
        (token) {
          _logger.info('Example feature loaded successfully.');
          return KResult<ExamplePayload>.value(
            ExamplePayload(summary: summary, sessionToken: token),
          );
        },
      );
    } catch (_) {
      return const KResult<ExamplePayload>.error(InternalFailure());
    }
  }

  Future<KResult<void>> resetSession() async {
    return _sessionService.resetSession();
  }
}
