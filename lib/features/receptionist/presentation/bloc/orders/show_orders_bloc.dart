import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'show_orders_event.dart';
import 'show_orders_state.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_orders/show_orders_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/show_orders/show_orders_usecase.dart';

@injectable
class ShowOrdersBloc extends Bloc<ShowOrdersEvent, ShowOrdersState> {
  ShowOrdersBloc(this._showOrdersUseCase) : super(const ShowOrdersState()) {
    on<ShowOrdersRequested>(_onRequested);
    on<ShowOrdersRefresh>(_onRefresh);
  }

  final ShowOrdersUseCase _showOrdersUseCase;

  Future<void> _onRequested(
    ShowOrdersRequested event,
    Emitter<ShowOrdersState> emit,
  ) async {
    emit(
  state.copyWith(
    isLoading: true,
    failure: null,
    currentStatus: event.status,
    currentPage: event.page,
    orders: const [],
  ),
);

    final result = await _showOrdersUseCase(
      ShowOrdersEntity(
        page: event.page,
        perPage: event.perPage,
        status: event.status,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, failure: failure));
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            failure: null,
            orders: response.data?.data ?? [],
            currentPage: response.data?.currentPage ?? event.page,
            lastPage: response.data?.lastPage ?? 1,
            currentStatus: event.status,
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

    add(ShowOrdersRequested(status: state.currentStatus!));
  }
}
