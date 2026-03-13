part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthAuthenticatedState extends AuthState {
  final String userName;
  final String email;

  const AuthAuthenticatedState({
    required this.userName,
    required this.email,
  });
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});
}
