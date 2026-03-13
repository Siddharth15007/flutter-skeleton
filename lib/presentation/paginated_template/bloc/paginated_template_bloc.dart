import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:flutter_bloc_template/models/template_list_item_model.dart';
import 'package:flutter_bloc_template/services/template_list_service.dart';

part 'paginated_template_event.dart';
part 'paginated_template_state.dart';

class PaginatedTemplateBloc
    extends Bloc<PaginatedTemplateEvent, PaginatedTemplateState> {
  final TemplateListService _templateListService;

  PaginatedTemplateBloc(this._templateListService)
      : super(const PaginatedTemplateState()) {
    on<LoadTemplateItemsEvent>(_onLoadTemplateItems, transformer: restartable());
    on<SearchTemplateItemsEvent>(
      _onSearchTemplateItems,
      transformer: restartable(),
    );
    on<LoadMoreTemplateItemsEvent>(
      _onLoadMoreTemplateItems,
      transformer: droppable(),
    );
  }

  Future<void> _onLoadTemplateItems(
    LoadTemplateItemsEvent event,
    Emitter<PaginatedTemplateState> emit,
  ) async {
    emit(state.copyWith(
      status: TemplateListStatus.loading,
      query: '',
      page: 1,
      items: <TemplateListItemModel>[],
      hasMore: true,
      errorMessage: null,
    ));

    final result = await _templateListService.fetchItems(page: 1, query: '');
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TemplateListStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (payload) => emit(
        state.copyWith(
          status: TemplateListStatus.success,
          items: payload.items,
          page: payload.page,
          hasMore: payload.hasMore,
          query: payload.query,
        ),
      ),
    );
  }

  Future<void> _onSearchTemplateItems(
    SearchTemplateItemsEvent event,
    Emitter<PaginatedTemplateState> emit,
  ) async {
    emit(state.copyWith(
      status: TemplateListStatus.loading,
      query: event.query,
      page: 1,
      items: <TemplateListItemModel>[],
      hasMore: true,
      errorMessage: null,
    ));

    final result = await _templateListService.fetchItems(
      page: 1,
      query: event.query,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TemplateListStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (payload) => emit(
        state.copyWith(
          status: TemplateListStatus.success,
          items: payload.items,
          page: payload.page,
          hasMore: payload.hasMore,
          query: payload.query,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreTemplateItems(
    LoadMoreTemplateItemsEvent event,
    Emitter<PaginatedTemplateState> emit,
  ) async {
    if (!state.hasMore || state.status == TemplateListStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: TemplateListStatus.loadingMore));
    final nextPage = state.page + 1;
    final result = await _templateListService.fetchItems(
      page: nextPage,
      query: state.query,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TemplateListStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (payload) => emit(
        state.copyWith(
          status: TemplateListStatus.success,
          items: <TemplateListItemModel>[
            ...state.items,
            ...payload.items,
          ],
          page: payload.page,
          hasMore: payload.hasMore,
        ),
      ),
    );
  }
}
