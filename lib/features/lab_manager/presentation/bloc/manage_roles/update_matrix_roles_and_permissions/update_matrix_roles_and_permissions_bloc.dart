
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/update_matrix_roles_and_permissions_usecase.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

import 'update_matrix_roles_and_permissions_event.dart';
import 'update_matrix_roles_and_permissions_state.dart';



@injectable
class UpdateMatrixRolesAndPermissonsBloc
    extends Bloc<UpdateMatrixRolesAndPermissonsEvent, UpdateMatrixRolesAndPermissonsState> {
  UpdateMatrixRolesAndPermissonsBloc(this._useCase)
      : super(const UpdateMatrixRolesAndPermissonsState()) {
    on<SubmitMatrixEvent>(_onSubmit);
  }

  final UpdateMatrixRolesAndPermissionsUseCase _useCase;

  Future<void> _onSubmit(
    SubmitMatrixEvent event,
    Emitter<UpdateMatrixRolesAndPermissonsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, failure: null));

    final result = await _useCase(event.params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          failure: failure,
        ));
      },
      (response) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          message: response.message,
        ));
      },
    );
  }
}