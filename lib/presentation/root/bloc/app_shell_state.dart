part of 'app_shell_bloc.dart';

sealed class AppShellState {
  const AppShellState();
}

class AppShellInitialState extends AppShellState {
  const AppShellInitialState();
}

class AppShellLoadingState extends AppShellState {
  const AppShellLoadingState();
}

class AppShellLoadedState extends AppShellState {
  final String appName;
  final String flavor;
  final String baseUrl;
  final String sessionToken;

  const AppShellLoadedState({
    required this.appName,
    required this.flavor,
    required this.baseUrl,
    required this.sessionToken,
  });
}

class AppShellErrorState extends AppShellState {
  final String message;

  const AppShellErrorState({required this.message});
}
