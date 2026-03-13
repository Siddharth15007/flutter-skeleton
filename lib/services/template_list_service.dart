import 'package:flutter_bloc_template/models/paginated_list_model.dart';
import 'package:flutter_bloc_template/models/template_list_item_model.dart';
import 'package:flutter_bloc_template/repositories/remote_repository/template_list_repository.dart';
import 'package:flutter_bloc_template/utils/result.dart';

class TemplateListService {
  final TemplateListRepository _repository;

  TemplateListService(this._repository);

  Future<KResult<PaginatedListModel<TemplateListItemModel>>> fetchItems({
    required int page,
    required String query,
  }) {
    return _repository.fetchItems(page: page, query: query);
  }
}
