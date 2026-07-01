import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/get_roles_usecase.dart';
import 'package:injectable/injectable.dart';

import 'roles_bloc_event.dart';
import 'roles_bloc_state.dart';

@injectable
class RolesBloc extends Bloc<RolesEvent, RolesBlocState> {
  RolesBloc({required this.getRolesUseCase}) : super(const RolesBlocState()) {
    on<RolesFetchRequested>(_onFetchRequested);
    add(const RolesFetchRequested());
  }

  final GetRolesUseCase getRolesUseCase;

  Future<void> _onFetchRequested(
    RolesFetchRequested event,
    Emitter<RolesBlocState> emit,
  ) async {
    emit(state.copyWith(status: RolesStatus.loading, clearFailure: true));

    final result = await getRolesUseCase(const NoParameters());

    result.fold(
      (failure) {
        emit(state.copyWith(status: RolesStatus.failure, failure: failure));
      },
      (response) {
        emit(
          state.copyWith(
            status: RolesStatus.success,
            response: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}
