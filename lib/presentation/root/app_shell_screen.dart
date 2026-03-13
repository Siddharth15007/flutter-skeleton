import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc_template/configure.dart';
import 'package:flutter_bloc_template/presentation/common/empty_state_widget.dart';
import 'package:flutter_bloc_template/presentation/root/bloc/app_shell_bloc.dart';
import 'package:flutter_bloc_template/presentation/root/context_extensions.dart';
import 'package:flutter_bloc_template/services/app_bootstrap_service.dart';
import 'package:flutter_bloc_template/utils/constants.dart';

class AppShellScreen extends StatelessWidget {
  final Widget child;

  const AppShellScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppShellBloc>(
      create: (context) => AppShellBloc(getIt<AppBootstrapService>())
        ..add(const LoadAppShellEvent()),
      child: _AppShellView(child: child),
    );
  }
}

class _AppShellView extends StatelessWidget {
  final Widget child;

  const _AppShellView({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppShellBloc, AppShellState>(
      builder: (context, state) {
        if (state is AppShellInitialState || state is AppShellLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AppShellErrorState) {
          return Scaffold(
            body: EmptyStateWidget(
              title: 'Bootstrap Failed',
              description: state.message,
              icon: Icons.error_outline,
            ),
          );
        }

        if (state is! AppShellLoadedState) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(state.appName),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(28),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.large,
                  right: AppSpacing.large,
                  bottom: AppSpacing.small,
                ),
                child: Row(
                  children: <Widget>[
                    _ShellBadge(label: state.environment.toUpperCase()),
                    const SizedBox(width: AppSpacing.small),
                    Expanded(
                      child: Text(
                        state.baseUrl,
                        style: context.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex(context),
            onDestinationSelected: (index) {
              context.go(AppRoutes.items[index].path);
            },
            destinations: AppRoutes.items
                .map(
                  (route) => NavigationDestination(
                    icon: Icon(route.icon),
                    label: route.label,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex =
        AppRoutes.items.indexWhere((route) => route.path == location);
    if (selectedIndex < 0) {
      return 0;
    }

    return selectedIndex;
  }
}

class _ShellBadge extends StatelessWidget {
  final String label;

  const _ShellBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: 4,
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
