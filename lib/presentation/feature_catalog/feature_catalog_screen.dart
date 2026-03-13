import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc_template/presentation/common/app_section_card.dart';
import 'package:flutter_bloc_template/presentation/common/empty_state_widget.dart';
import 'package:flutter_bloc_template/presentation/auth/auth_screen.dart';
import 'package:flutter_bloc_template/presentation/paginated_template/paginated_template_screen.dart';
import 'package:flutter_bloc_template/presentation/root/context_extensions.dart';
import 'package:flutter_bloc_template/utils/constants.dart';

class FeatureCatalogScreen extends StatelessWidget {
  static const String id = 'feature_catalog';
  static const String path = '/feature-catalog';

  const FeatureCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.large),
      children: const <Widget>[
        _FeatureCatalogHero(),
        SizedBox(height: AppSpacing.large),
        _FeatureLinks(),
        SizedBox(height: AppSpacing.large),
        _FeatureChecklist(),
      ],
    );
  }
}

class _FeatureCatalogHero extends StatelessWidget {
  const _FeatureCatalogHero();

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      title: 'Feature Slots Ready',
      description:
          'Duplicate the example feature and replace only repository, service, bloc, and screen content for each new module.',
      icon: Icons.widgets_outlined,
    );
  }
}

class _FeatureLinks extends StatelessWidget {
  const _FeatureLinks();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Included Feature Seeds',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          Wrap(
            spacing: AppSpacing.small,
            runSpacing: AppSpacing.small,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: () => context.go(PaginatedTemplateScreen.path),
                child: const Text('Pagination Template'),
              ),
              FilledButton.tonal(
                onPressed: () => context.go(AuthScreen.path),
                child: const Text('Auth Template'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureChecklist extends StatelessWidget {
  const _FeatureChecklist();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'When Adding A New Feature',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          for (final step in AppTemplateMessages.featureSteps)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.small),
              child: Text('• $step'),
            ),
        ],
      ),
    );
  }
}
