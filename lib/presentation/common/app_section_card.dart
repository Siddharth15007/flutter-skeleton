import 'package:flutter/material.dart';

import 'package:flutter_bloc_template/utils/constants.dart';

class AppSectionCard extends StatelessWidget {
  final Widget child;

  const AppSectionCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: child,
      ),
    );
  }
}
