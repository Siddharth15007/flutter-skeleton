import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:flutter_skeleton/services/example_service.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleService _exampleService;

  ExampleBloc(this._exampleService) : super(const ExampleInitialState()) {
    on<LoadExampleEvent>(_onLoadExample, transformer: sequential());
    on<ResetSessionEvent>(_onResetSession, transformer: sequential());
  }

  Future<void> _onLoadExample(
    LoadExampleEvent event,
    Emitter<ExampleState> emit,
  ) async {
    emit(const ExampleLoadingState());

    final result = await _exampleService.loadExample();
    result.fold(
      (failure) => emit(ExampleErrorState(message: failure.message)),
      (payload) => emit(
        ExampleLoadedState(
          title: payload.summary.title,
          description: payload.summary.description,
          highlights: payload.summary.highlights,
          sessionToken: payload.sessionToken,
        ),
      ),
    );
  }

  Future<void> _onResetSession(
    ResetSessionEvent event,
    Emitter<ExampleState> emit,
  ) async {
    final result = await _exampleService.resetSession();
    result.fold(
      (failure) => emit(ExampleErrorState(message: failure.message)),
      (_) => add(const LoadExampleEvent()),
    );
  }
}
