part of 'example_bloc.dart';

sealed class ExampleState {
  const ExampleState();
}

class ExampleInitialState extends ExampleState {
  const ExampleInitialState();
}

class ExampleLoadingState extends ExampleState {
  const ExampleLoadingState();
}

class ExampleLoadedState extends ExampleState {
  final String title;
  final String description;
  final List<String> highlights;
  final String sessionToken;

  const ExampleLoadedState({
    required this.title,
    required this.description,
    required this.highlights,
    required this.sessionToken,
  });
}

class ExampleErrorState extends ExampleState {
  final String message;

  const ExampleErrorState({required this.message});
}
