import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:flutter_bloc_template/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(const AuthInitialState()) {
    on<LoginRequestedEvent>(_onLoginRequested, transformer: sequential());
    on<LogoutRequestedEvent>(_onLogoutRequested, transformer: sequential());
  }

  Future<void> _onLoginRequested(
    LoginRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    final result = await _authService.login(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (session) => emit(
        AuthAuthenticatedState(
          userName: session.userName,
          email: event.email,
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authService.logout();
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (_) => emit(const AuthInitialState()),
    );
  }
}
