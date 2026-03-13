import 'dart:async';

import 'package:flutter_bloc_template/models/example_summary_model.dart';

abstract class ExampleRepository {
  Future<ExampleSummaryModel> fetchSummary();
}

class MockExampleRepository extends ExampleRepository {
  @override
  Future<ExampleSummaryModel> fetchSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    return const ExampleSummaryModel(
      title: 'Reusable Template Project',
      description:
          'A feature-first Flutter template with flutter_bloc, routing, DI, and secure abstractions.',
      highlights: <String>[
        'Rename the package and app strings to bootstrap a new product',
        'Replace the mock repository with real API and storage implementations',
        'Duplicate the example feature folder to scaffold new features consistently',
      ],
    );
  }
}
