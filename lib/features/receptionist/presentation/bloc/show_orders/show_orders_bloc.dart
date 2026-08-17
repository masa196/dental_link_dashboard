import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'show_orders_event.dart';
import 'show_orders_state.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/show_orders_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/show_orders_usecase.dart';

@injectable
class ShowOrdersBloc extends Bloc<ShowOrdersEvent, ShowOrdersState> {
  ShowOrdersBloc(this._showOrdersUseCase)
      : super(const ShowOrdersState()) {
    on<ShowOrdersRequested>(_onRequested);
    on<ShowOrdersRefresh>(_onRefresh);
  }

  final ShowOrdersUseCase _showOrdersUseCase;

  Future<void> _onRequested(
    ShowOrdersRequested event,
    Emitter<ShowOrdersState> emit,
  ) async {
    // Preserve the existing priority logic.
    final priority = event.clearPriority
        ? null
        : (event.priority ?? state.currentPriority);

    // Normalize search.
    final String? search;

    if (event.clearSearch) {
      search = null;
    } else if (event.search != null) {
      final normalizedSearch = event.search!.trim();

      search = normalizedSearch.isEmpty ? null : normalizedSearch;
    } else {
      search = state.currentSearch;
    }

    // HARD RESET when ALL is selected.
    final isReset = event.clearPriority;

    if (isReset) {
      emit(
        ShowOrdersState(
          orders: const [],
          currentPage: 1,
          lastPage: 1,
          currentStatus: null,
          currentPriority: null,
          currentSearch: search,
          isLoading: true,
          failure: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: true,
          failure: null,
          currentStatus: event.status,
          currentPriority: priority,
          currentSearch: search,
          clearSearch: search == null,
        ),
      );
    }

    final result = await _showOrdersUseCase(
      ShowOrdersEntity(
        page: event.page,
        perPage: event.perPage,
        status: event.status,
        priority: priority,
        search: search,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            failure: failure,
          ),
        );
      },
      (response) {
        final orders = response.data?.data ?? [];

        if (orders.isEmpty && event.page > 1) {
          add(
            ShowOrdersRequested(
              status: event.status,
              page: event.page - 1,
              perPage: event.perPage,
              priority: priority,
              search: search,
              clearPriority: event.clearPriority,
              clearSearch: search == null,
            ),
          );

          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            orders: orders,
            currentPage: response.data?.currentPage ?? event.page,
            lastPage: response.data?.lastPage ?? 1,
            currentStatus: event.status,
            currentPriority: priority,
            currentSearch: search,
            clearSearch: search == null,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    ShowOrdersRefresh event,
    Emitter<ShowOrdersState> emit,
  ) async {
    if (state.currentStatus == null) return;

    add(
      ShowOrdersRequested(
        status: state.currentStatus!,
        page: state.currentPage,
        priority: state.currentPriority,
        search: state.currentSearch,
      ),
    );
  }
}