import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_employees_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_delivery/show_delivery_employees_usecase.dart';

import 'show_delivery_employees_event.dart';
import 'show_delivery_employees_state.dart';

@injectable
class ShowDeliveryEmployeesBloc
    extends Bloc<
        ShowDeliveryEmployeesEvent,
        ShowDeliveryEmployeesState> {
  final ShowDeliveryEmployeesUsecase _usecase;

  ShowDeliveryEmployeesBloc(
    this._usecase,
  ) : super(const ShowDeliveryEmployeesState()) {
    on<LoadDeliveryEmployees>(_onLoadDeliveryEmployees);
  }

  Future<void> _onLoadDeliveryEmployees(
    LoadDeliveryEmployees event,
    Emitter<ShowDeliveryEmployeesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ShowDeliveryEmployeesStatus.loading,
      ),
    );

    final result = await _usecase(
      ShowDeliveryEmployeesEntity(
        perPage: event.perPage,
        search: event.search,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ShowDeliveryEmployeesStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: ShowDeliveryEmployeesStatus.success,
            response: response,
          ),
        );
      },
    );
  }
}