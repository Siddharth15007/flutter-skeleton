part of 'paginated_template_bloc.dart';

enum TemplateListStatus {
  initial,
  loading,
  success,
  loadingMore,
  error,
}

class PaginatedTemplateState {
  final TemplateListStatus status;
  final List<TemplateListItemModel> items;
  final int page;
  final bool hasMore;
  final String query;
  final String? errorMessage;

  const PaginatedTemplateState({
    this.status = TemplateListStatus.initial,
    this.items = const <TemplateListItemModel>[],
    this.page = 1,
    this.hasMore = true,
    this.query = '',
    this.errorMessage,
  });

  PaginatedTemplateState copyWith({
    TemplateListStatus? status,
    List<TemplateListItemModel>? items,
    int? page,
    bool? hasMore,
    String? query,
    String? errorMessage,
  }) {
    return PaginatedTemplateState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
      errorMessage: errorMessage,
    );
  }
}
