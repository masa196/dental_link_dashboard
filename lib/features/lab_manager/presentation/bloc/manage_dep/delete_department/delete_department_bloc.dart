import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/delete_department_use_case.dart';

import 'delete_department_bloc_event.dart';
import 'delete_department_bloc_state.dart';

@injectable
class DeleteDepartmentBloc
    extends Bloc<DeleteDepartmentBlocEvent, DeleteDepartmentBlocState> {
  DeleteDepartmentBloc({required this.deleteDepartmentUseCase})
    : super(const DeleteDepartmentBlocState()) {
    on<DeleteDepartmentSubmitted>(_onSubmitted);
    on<DeleteDepartmentReset>(_onReset);
  }

  final DeleteDepartmentUseCase deleteDepartmentUseCase;

  Future<void> _onSubmitted(
    DeleteDepartmentSubmitted event,
    Emitter<DeleteDepartmentBlocState> emit,
  ) async {
    emit(state.copyWith(status: DeleteDepartmentStatus.loading));

    final result = await deleteDepartmentUseCase(event.departmentId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: DeleteDepartmentStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: DeleteDepartmentStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    DeleteDepartmentReset event,
    Emitter<DeleteDepartmentBlocState> emit,
  ) async {
    emit(const DeleteDepartmentBlocState());
  }
}
