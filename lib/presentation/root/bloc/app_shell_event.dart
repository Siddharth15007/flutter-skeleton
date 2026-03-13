part of 'app_shell_bloc.dart';

sealed class AppShellEvent {
  const AppShellEvent();
}

class LoadAppShellEvent extends AppShellEvent {
  const LoadAppShellEvent();
}
