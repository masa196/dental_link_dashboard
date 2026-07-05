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
    // 🔥 CORE FIX: normalize priority properly
    final priority = event.clearPriority
        ? null
        : (event.priority ?? state.currentPriority);

    // 🔥 HARD RESET when ALL is selected
    final isReset = event.clearPriority;

    if (isReset) {
      emit(const ShowOrdersState(
        orders: [],
        currentPage: 1,
        lastPage: 1,
        currentStatus: null,
        currentPriority: null,
        isLoading: true,
        failure: null,
      ));
    } else {
      emit(
        state.copyWith(
          isLoading: true,
          failure: null,
          currentStatus: event.status,
          currentPriority: priority,
        ),
      );
    }

    final result = await _showOrdersUseCase(
      ShowOrdersEntity(
        page: event.page,
        perPage: event.perPage,
        status: event.status,
        priority: priority,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          failure: failure,
        ));
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
              clearPriority: event.clearPriority,
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
      ),
    );
  }
}