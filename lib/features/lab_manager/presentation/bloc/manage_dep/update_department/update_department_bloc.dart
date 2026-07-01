import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/update_department_use_case.dart';

import 'update_department_bloc_event.dart';
import 'update_department_bloc_state.dart';

@injectable
class UpdateDepartmentBloc
    extends Bloc<UpdateDepartmentBlocEvent, UpdateDepartmentBlocState> {
  UpdateDepartmentBloc({required this.updateDepartmentUseCase})
    : super(const UpdateDepartmentBlocState()) {
    on<UpdateDepartmentSubmitted>(_onSubmitted);
    on<UpdateDepartmentReset>(_onReset);
  }

  final UpdateDepartmentUseCase updateDepartmentUseCase;

  Future<void> _onSubmitted(
    UpdateDepartmentSubmitted event,
    Emitter<UpdateDepartmentBlocState> emit,
  ) async {
    emit(state.copyWith(status: UpdateDepartmentStatus.loading));

    final result = await updateDepartmentUseCase(
      event.departmentId,
      event.params,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: UpdateDepartmentStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: UpdateDepartmentStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    UpdateDepartmentReset event,
    Emitter<UpdateDepartmentBlocState> emit,
  ) async {
    emit(const UpdateDepartmentBlocState());
  }
}
