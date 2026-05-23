import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/create_lab_manager/create_lab_manager_use_case.dart';

import 'create_lab_manager_bloc_event.dart';
import 'create_lab_manager_bloc_state.dart';

@injectable
class CreateLabManagerBloc
    extends Bloc<CreateLabManagerBlocEvent, CreateLabManagerBlocState> {
  CreateLabManagerBloc({required this.createLabManagerUseCase})
    : super(const CreateLabManagerBlocState()) {
    on<CreateLabManagerSubmitted>(_onSubmitted);
    on<CreateLabManagerReset>(_onReset);
  }

  final CreateLabManagerUseCase createLabManagerUseCase;

  Future<void> _onSubmitted(
    CreateLabManagerSubmitted event,
    Emitter<CreateLabManagerBlocState> emit,
  ) async {
    emit(state.copyWith(status: CreateLabManagerRemoteStatus.loading));

    final result = await createLabManagerUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateLabManagerRemoteStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: CreateLabManagerRemoteStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    CreateLabManagerReset event,
    Emitter<CreateLabManagerBlocState> emit,
  ) async {
    emit(const CreateLabManagerBlocState());
  }
}
