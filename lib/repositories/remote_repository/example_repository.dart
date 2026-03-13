import 'dart:async';

import 'package:flutter_skeleton/models/example_summary_model.dart';

abstract class ExampleRepository {
  Future<ExampleSummaryModel> fetchSummary();
}

class MockExampleRepository extends ExampleRepository {
  @override
  Future<ExampleSummaryModel> fetchSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    return const ExampleSummaryModel(
      title: 'Flutter Skeleton',
      description:
          'A feature-first starter with flutter_bloc, routing, DI, and secure abstractions.',
      highlights: <String>[
        'Layered architecture with repository and service boundaries',
        'Typed failure and result handling',
        'Reusable theme, router, and context extensions',
      ],
    );
  }
}
