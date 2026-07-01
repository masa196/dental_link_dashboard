import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/delete_role_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'delete_role_event.dart';
import 'delete_role_state.dart';

@injectable
class DeleteRoleBloc extends Bloc<DeleteRoleEvent, DeleteRoleState> {
  final DeleteRoleUseCase _useCase;

  DeleteRoleBloc(this._useCase) : super(const DeleteRoleState()) {
    on<SubmitDeleteRoleEvent>(_onDelete);
    on<ResetDeleteRoleState>(_onReset);
  }

  Future<void> _onDelete(
    SubmitDeleteRoleEvent event,
    Emitter<DeleteRoleState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        failure: null,
        message: null,
      ),
    );

    final result = await _useCase(event.roleId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            failure: failure,
            message: null,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            failure: null,
            message: response.message,
          ),
        );
      },
    );
  }

  void _onReset(
    ResetDeleteRoleState event,
    Emitter<DeleteRoleState> emit,
  ) {
    emit(const DeleteRoleState());
  }
}