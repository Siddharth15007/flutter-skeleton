import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_template/configure.dart';
import 'package:flutter_bloc_template/presentation/common/app_section_card.dart';
import 'package:flutter_bloc_template/presentation/paginated_template/bloc/paginated_template_bloc.dart';
import 'package:flutter_bloc_template/presentation/root/context_extensions.dart';
import 'package:flutter_bloc_template/services/template_list_service.dart';
import 'package:flutter_bloc_template/utils/constants.dart';

class PaginatedTemplateScreen extends StatelessWidget {
  static const String id = 'paginated_template';
  static const String path = '/paginated-template';

  const PaginatedTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaginatedTemplateBloc>(
      create: (context) => PaginatedTemplateBloc(getIt<TemplateListService>())
        ..add(const LoadTemplateItemsEvent()),
      child: const _PaginatedTemplatePage(),
    );
  }
}

class _PaginatedTemplatePage extends StatelessWidget {
  const _PaginatedTemplatePage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginatedTemplateBloc, PaginatedTemplateState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.large),
          children: <Widget>[
            AppSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Paginated Search Template',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search feature seed',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      context.read<PaginatedTemplateBloc>().add(
                            SearchTemplateItemsEvent(value.trim()),
                          );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            if (state.status == TemplateListStatus.loading)
              const Center(child: CircularProgressIndicator()),
            if (state.status == TemplateListStatus.error &&
                state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.medium),
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(color: context.colors.error),
                ),
              ),
            for (final item in state.items)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.medium),
                child: AppSectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.small),
                      Text(item.subtitle),
                    ],
                  ),
                ),
              ),
            if (state.status == TemplateListStatus.loadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.medium),
                child: Center(child: CircularProgressIndicator()),
              ),
            if (state.hasMore &&
                state.status != TemplateListStatus.loading &&
                state.status != TemplateListStatus.loadingMore)
              FilledButton.tonal(
                onPressed: () {
                  context
                      .read<PaginatedTemplateBloc>()
                      .add(const LoadMoreTemplateItemsEvent());
                },
                child: const Text('Load More'),
              ),
          ],
        );
      },
    );
  }
}
