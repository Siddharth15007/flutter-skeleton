import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_template/configure.dart';
import 'package:flutter_bloc_template/presentation/common/app_section_card.dart';
import 'package:flutter_bloc_template/presentation/example/bloc/example_bloc.dart';
import 'package:flutter_bloc_template/presentation/root/context_extensions.dart';
import 'package:flutter_bloc_template/services/example_service.dart';
import 'package:flutter_bloc_template/utils/constants.dart' show AppSpacing;

class ExampleScreen extends StatelessWidget {
  static const String id = 'example';
  static const String path = '/';

  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExampleBloc>(
      create: (context) => ExampleBloc(getIt<ExampleService>())
        ..add(const LoadExampleEvent()),
      child: const _ExamplePage(),
    );
  }
}

class _ExamplePage extends StatelessWidget {
  const _ExamplePage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ExampleBloc, ExampleState>(
        builder: (context, state) {
          if (state is ExampleLoadingState || state is ExampleInitialState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ExampleErrorState) {
            return _ErrorView(message: state.message);
          }

          if (state is ExampleLoadedState) {
            return _LoadedView(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final ExampleLoadedState state;

  const _LoadedView({required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.large),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(AppSpacing.large),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF0B5FFF), Color(0xFF11A36A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.large),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                state.title,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                state.description,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.92),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.large),
        AppSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Architecture Highlights',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.medium),
              for (final highlight in state.highlights)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.small),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.verified_user_outlined,
                        color: context.colors.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.small),
                      Expanded(
                        child: Text(highlight),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.large),
        AppSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Demo Secure Session',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                state.sessionToken,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: AppSpacing.medium),
              FilledButton.icon(
                onPressed: () {
                  context.read<ExampleBloc>().add(const ResetSessionEvent());
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset Session'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: context.colors.error,
              size: 40,
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.medium),
            FilledButton(
              onPressed: () {
                context.read<ExampleBloc>().add(const LoadExampleEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
