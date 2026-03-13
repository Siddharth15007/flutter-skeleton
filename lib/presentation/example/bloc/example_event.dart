part of 'example_bloc.dart';

sealed class ExampleEvent {
  const ExampleEvent();
}

class LoadExampleEvent extends ExampleEvent {
  const LoadExampleEvent();
}

class ResetSessionEvent extends ExampleEvent {
  const ResetSessionEvent();
}
