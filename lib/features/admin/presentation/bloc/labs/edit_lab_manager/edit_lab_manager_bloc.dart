import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/edit_lab_manager/edit_lab_manager_use_case.dart';

import 'edit_lab_manager_bloc_event.dart';
import 'edit_lab_manager_bloc_state.dart';

@injectable
class EditLabManagerBloc
    extends Bloc<EditLabManagerBlocEvent, EditLabManagerBlocState> {
  EditLabManagerBloc({required this.editLabManagerUseCase})
    : super(const EditLabManagerBlocState()) {
    on<EditLabManagerSubmitted>(_onSubmitted);
    on<EditLabManagerReset>(_onReset);
  }

  final EditLabManagerUseCase editLabManagerUseCase;

  Future<void> _onSubmitted(
    EditLabManagerSubmitted event,
    Emitter<EditLabManagerBlocState> emit,
  ) async {
    emit(state.copyWith(status: EditLabManagerRemoteStatus.loading));

    final result = await editLabManagerUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: EditLabManagerRemoteStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: EditLabManagerRemoteStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    EditLabManagerReset event,
    Emitter<EditLabManagerBlocState> emit,
  ) async {
    emit(const EditLabManagerBlocState());
  }
}
