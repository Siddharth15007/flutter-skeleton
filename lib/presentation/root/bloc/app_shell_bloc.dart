import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:flutter_bloc_template/services/app_bootstrap_service.dart';

part 'app_shell_event.dart';
part 'app_shell_state.dart';

class AppShellBloc extends Bloc<AppShellEvent, AppShellState> {
  final AppBootstrapService _appBootstrapService;

  AppShellBloc(this._appBootstrapService)
      : super(const AppShellInitialState()) {
    on<LoadAppShellEvent>(_onLoadAppShell, transformer: sequential());
  }

  Future<void> _onLoadAppShell(
    LoadAppShellEvent event,
    Emitter<AppShellState> emit,
  ) async {
    emit(const AppShellLoadingState());

    final result = await _appBootstrapService.bootstrap();
    result.fold(
      (failure) => emit(AppShellErrorState(message: failure.message)),
      (payload) => emit(
        AppShellLoadedState(
          appName: payload.config.appName,
          flavor: payload.config.flavor,
          baseUrl: payload.config.baseUrl,
          sessionToken: payload.sessionToken,
        ),
      ),
    );
  }
}
