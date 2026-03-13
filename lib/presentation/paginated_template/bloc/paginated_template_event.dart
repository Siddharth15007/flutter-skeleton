part of 'paginated_template_bloc.dart';

sealed class PaginatedTemplateEvent {
  const PaginatedTemplateEvent();
}

class LoadTemplateItemsEvent extends PaginatedTemplateEvent {
  const LoadTemplateItemsEvent();
}

class SearchTemplateItemsEvent extends PaginatedTemplateEvent {
  final String query;

  const SearchTemplateItemsEvent(this.query);
}

class LoadMoreTemplateItemsEvent extends PaginatedTemplateEvent {
  const LoadMoreTemplateItemsEvent();
}
