import 'package:flutter_bloc_template/models/paginated_list_model.dart';
import 'package:flutter_bloc_template/models/template_list_item_model.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/api_client.dart';
import 'package:flutter_bloc_template/utils/result.dart';

abstract class TemplateListRepository {
  Future<KResult<PaginatedListModel<TemplateListItemModel>>> fetchItems({
    required int page,
    required String query,
  });
}

class MockTemplateListRepository extends TemplateListRepository {
  final ApiClient _apiClient;

  MockTemplateListRepository(this._apiClient);

  @override
  Future<KResult<PaginatedListModel<TemplateListItemModel>>> fetchItems({
    required int page,
    required String query,
  }) async {
    final result = await _apiClient.get(
      '/template/items?page=$page&query=$query',
    );

    return result.fold(
      KResult<PaginatedListModel<TemplateListItemModel>>.error,
      (_) {
        final items = List<TemplateListItemModel>.generate(
          12,
          (index) => TemplateListItemModel(
            id: 'page-$page-item-$index',
            title: 'Template Item ${index + 1 + ((page - 1) * 12)}',
            subtitle: query.isEmpty
                ? 'Ready to replace with your domain data.'
                : 'Search seed for "$query".',
          ),
        );

        return KResult<PaginatedListModel<TemplateListItemModel>>.value(
          PaginatedListModel<TemplateListItemModel>(
            items: items,
            page: page,
            hasMore: page < 3,
            query: query,
          ),
        );
      },
    );
  }
}
