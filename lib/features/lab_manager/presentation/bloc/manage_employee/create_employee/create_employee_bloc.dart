import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/create_employee_usecase.dart';
import 'package:injectable/injectable.dart';

import 'create_employee_bloc_event.dart';
import 'create_employee_bloc_state.dart';

@injectable
class CreateEmployeeBloc
    extends Bloc<CreateEmployeeEvent, CreateEmployeeBlocState> {
  CreateEmployeeBloc({required this.createEmployeeUseCase})
    : super(const CreateEmployeeBlocState()) {
    on<CreateEmployeeSubmitted>(_onSubmitted);
    on<CreateEmployeeReset>(_onReset);
  }

  final CreateEmployeeUseCase createEmployeeUseCase;

  Future<void> _onSubmitted(
    CreateEmployeeSubmitted event,
    Emitter<CreateEmployeeBlocState> emit,
  ) async {
    emit(
      state.copyWith(status: CreateEmployeeStatus.loading, clearFailure: true),
    );

    final result = await createEmployeeUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateEmployeeStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: CreateEmployeeStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    CreateEmployeeReset event,
    Emitter<CreateEmployeeBlocState> emit,
  ) async {
    emit(const CreateEmployeeBlocState());
  }
}
