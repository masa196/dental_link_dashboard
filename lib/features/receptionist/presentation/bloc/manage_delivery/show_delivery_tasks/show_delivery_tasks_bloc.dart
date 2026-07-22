import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'show_delivery_tasks_event.dart';
import 'show_delivery_tasks_state.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_tasks_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_delivery/show_delivery_tasks_usecase.dart';

@injectable
class ShowDeliveryTasksBloc
    extends Bloc<ShowDeliveryTasksEvent, ShowDeliveryTasksState> {
  ShowDeliveryTasksBloc(this._showDeliveryTasksUsecase)
      : super(const ShowDeliveryTasksState()) {
    on<ShowDeliveryTasksRequested>(_onRequested);
    on<ShowDeliveryTasksRefresh>(_onRefresh);
  }

  final ShowDeliveryTasksUsecase _showDeliveryTasksUsecase;

  Future<void> _onRequested(
    ShowDeliveryTasksRequested event,
    Emitter<ShowDeliveryTasksState> emit,
  ) async {
    final search = event.search ?? state.currentSearch;

    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
        currentSearch: search,
      ),
    );

    final result = await _showDeliveryTasksUsecase(
      ShowDeliveryTasksEntity(
        page: event.page,
        perPage: event.perPage,
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
        final tasks = response.data?.data ?? [];

        /// نفس منطق صفحة الطلبات
        if (tasks.isEmpty && event.page > 1) {
          add(
            ShowDeliveryTasksRequested(
              page: event.page - 1,
              perPage: event.perPage,
              search: search,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            tasks: tasks,
            currentPage:
                response.data?.meta?.currentPage ?? event.page,
            lastPage:
                response.data?.meta?.lastPage ?? 1,
            currentSearch: search,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    ShowDeliveryTasksRefresh event,
    Emitter<ShowDeliveryTasksState> emit,
  ) async {
    add(
      ShowDeliveryTasksRequested(
        page: state.currentPage,
        search: state.currentSearch,
      ),
    );
  }
}