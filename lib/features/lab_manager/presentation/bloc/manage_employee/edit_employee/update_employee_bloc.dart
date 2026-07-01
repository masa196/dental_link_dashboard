import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/update_employee_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

import 'update_employee_bloc_event.dart';
import 'update_employee_bloc_state.dart';

@injectable
class UpdateEmployeeBloc
    extends Bloc<UpdateEmployeeEvent, UpdateEmployeeBlocState> {
  UpdateEmployeeBloc({required this.updateEmployeeUseCase})
    : super(const UpdateEmployeeBlocState()) {
    on<UpdateEmployeeSubmitted>(_onSubmitted);
    on<UpdateEmployeeReset>(_onReset);
  }

  final UpdateEmployeeUseCase updateEmployeeUseCase;

  Future<void> _onSubmitted(
    UpdateEmployeeSubmitted event,
    Emitter<UpdateEmployeeBlocState> emit,
  ) async {
    emit(
      state.copyWith(status: UpdateEmployeeStatus.loading, clearFailure: true),
    );

    final result = await updateEmployeeUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: UpdateEmployeeStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: UpdateEmployeeStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    UpdateEmployeeReset event,
    Emitter<UpdateEmployeeBlocState> emit,
  ) async {
    emit(const UpdateEmployeeBlocState());
  }
}