import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/delete_lab_manager/delete_lab_manager_use_case.dart';

import 'delete_lab_manager_bloc_event.dart';
import 'delete_lab_manager_bloc_state.dart';

@injectable
class DeleteLabManagerBloc
    extends Bloc<DeleteLabManagerBlocEvent, DeleteLabManagerBlocState> {
  DeleteLabManagerBloc({required this.deleteLabManagerUseCase})
    : super(const DeleteLabManagerBlocState()) {
    on<DeleteLabManagerSubmitted>(_onSubmitted);
    on<DeleteLabManagerReset>(_onReset);
  }

  final DeleteLabManagerUseCase deleteLabManagerUseCase;

  Future<void> _onSubmitted(
    DeleteLabManagerSubmitted event,
    Emitter<DeleteLabManagerBlocState> emit,
  ) async {
    emit(state.copyWith(status: DeleteLabManagerRemoteStatus.loading));

    final result = await deleteLabManagerUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: DeleteLabManagerRemoteStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: DeleteLabManagerRemoteStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    DeleteLabManagerReset event,
    Emitter<DeleteLabManagerBlocState> emit,
  ) async {
    emit(const DeleteLabManagerBlocState());
  }
}
