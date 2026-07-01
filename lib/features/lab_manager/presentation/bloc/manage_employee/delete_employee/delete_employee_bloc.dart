import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/delete_employee_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'delete_employee_bloc_event.dart';
import 'delete_employee_bloc_state.dart';

@injectable
class DeleteEmployeeBloc
    extends Bloc<DeleteEmployeeBlocEvent, DeleteEmployeeBlocState> {
  DeleteEmployeeBloc({required this.deleteEmployeeUseCase})
    : super(const DeleteEmployeeBlocState()) {
    on<DeleteEmployeeSubmitted>(_onSubmitted);
    on<DeleteEmployeeReset>(_onReset);
  }

  final DeleteEmployeeUseCase deleteEmployeeUseCase;

  Future<void> _onSubmitted(
    DeleteEmployeeSubmitted event,
    Emitter<DeleteEmployeeBlocState> emit,
  ) async {
    emit(state.copyWith(status: DeleteEmployeeStatus.loading));

    final result = await deleteEmployeeUseCase(event.employeeId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: DeleteEmployeeStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: DeleteEmployeeStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    DeleteEmployeeReset event,
    Emitter<DeleteEmployeeBlocState> emit,
  ) async {
    emit(const DeleteEmployeeBlocState());
  }
}
