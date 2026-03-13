import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_template/configure.dart';
import 'package:flutter_bloc_template/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_template/presentation/common/app_section_card.dart';
import 'package:flutter_bloc_template/presentation/root/context_extensions.dart';
import 'package:flutter_bloc_template/services/auth_service.dart';
import 'package:flutter_bloc_template/utils/constants.dart';

class AuthScreen extends StatelessWidget {
  static const String id = 'auth';
  static const String path = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(getIt<AuthService>()),
      child: const _AuthPage(),
    );
  }
}

class _AuthPage extends StatefulWidget {
  const _AuthPage();

  @override
  State<_AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<_AuthPage> {
  final TextEditingController _emailController = TextEditingController(
    text: 'demo@example.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'password123',
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.large),
          children: <Widget>[
            AppSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Auth Module Template',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    'Use this screen as the base for login, logout, OTP, or session-refresh flows.',
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  FilledButton(
                    onPressed: state is AuthLoadingState
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  LoginRequestedEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                          },
                    child: Text(
                      state is AuthLoadingState ? 'Signing In...' : 'Sign In',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            if (state is AuthAuthenticatedState)
              AppSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Authenticated State',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Text('User: ${state.userName}'),
                    Text('Email: ${state.email}'),
                    const SizedBox(height: AppSpacing.medium),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const LogoutRequestedEvent());
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            if (state is AuthErrorState)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.medium),
                child: Text(
                  state.message,
                  style: TextStyle(color: context.colors.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
