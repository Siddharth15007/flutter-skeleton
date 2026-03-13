class PaginatedListModel<T> {
  final List<T> items;
  final int page;
  final bool hasMore;
  final String query;

  const PaginatedListModel({
    required this.items,
    required this.page,
    required this.hasMore,
    required this.query,
  });
}
