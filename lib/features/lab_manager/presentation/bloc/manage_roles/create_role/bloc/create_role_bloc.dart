import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'create_role_event.dart';
import 'create_role_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/create_role_usecase.dart';

@injectable
class CreateRoleBloc extends Bloc<CreateRoleEvent, CreateRoleState> {
  final CreateRoleUseCase _useCase;

  CreateRoleBloc(this._useCase) : super(const CreateRoleState()) {
    on<SubmitCreateRoleEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitCreateRoleEvent event,
    Emitter<CreateRoleState> emit,
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
        emit(state.copyWith(isSuccess: false));
      },
    );
  }
}