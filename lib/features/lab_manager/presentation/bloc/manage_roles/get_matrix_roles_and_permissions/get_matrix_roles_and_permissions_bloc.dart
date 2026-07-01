import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/get_matrix_roles_and_permissions_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'get_matrix_roles_and_permissions_event.dart';
import 'get_matrix_roles_and_permissions_state.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetMatrixRolesAndPermissionsBloc extends Bloc<
    GetMatrixRolesAndPermissionsEvent,
    GetMatrixRolesAndPermissionsState> {
  GetMatrixRolesAndPermissionsBloc(this._useCase)
      : super(GetMatrixRolesAndPermissionsState.initial()) {
    on<LoadMatrixRolesAndPermissions>(_load);

    on<RefreshMatrixRolesAndPermissions>(_load);
  }

  final GetMatrixRolesAndPermissionsUseCase _useCase;

  Future<void> _load(
    GetMatrixRolesAndPermissionsEvent event,
    Emitter<GetMatrixRolesAndPermissionsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isFailure: false,
        isSuccess: false,
      ),
    );

    final result = await _useCase(NoParameters());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailure: true,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            response: response,
          ),
        );
      },
    );
  }
}