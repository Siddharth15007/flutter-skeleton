import 'package:flutter/material.dart';

import 'package:flutter_bloc_template/presentation/common/app_section_card.dart';
import 'package:flutter_bloc_template/presentation/root/context_extensions.dart';
import 'package:flutter_bloc_template/utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'settings';
  static const String path = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.large),
      children: <Widget>[
        AppSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Production Hardening Checklist',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.medium),
              for (final item in AppTemplateMessages.productionChecklist)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.small),
                  child: Text('• $item'),
                ),
              const SizedBox(height: AppSpacing.medium),
              Text(
                'Flavor generation command: dart run kflavor generate',
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
