import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/get_all_permissions_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'get_all_permissions_event.dart';
import 'get_all_permissions_state.dart';

@injectable
class GetAllPermissionsBloc
    extends Bloc<GetAllPermissionsEvent, GetAllPermissionsState> {
  GetAllPermissionsBloc(this._useCase)
      : super(const GetAllPermissionsState()) {
    on<LoadAllPermissions>(_onLoad);
  }

  final GetAllPermissionsUseCase _useCase;

  Future<void> _onLoad(
    LoadAllPermissions event,
    Emitter<GetAllPermissionsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
      ),
    );

    final result = await _useCase(NoParameters());

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