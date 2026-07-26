import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/lab_manager_profile/show_lab_manager_profile_usecase.dart';

import 'lab_manager_profile_event.dart';
import 'lab_manager_profile_state.dart';

@injectable
class LabManagerProfileBloc
    extends Bloc<LabManagerProfileEvent, LabManagerProfileState> {
  LabManagerProfileBloc({
    required this.showLabManagerProfileUseCase,
  }) : super(const LabManagerProfileState()) {
    on<LabManagerProfileFetchRequested>(_onFetchRequested);

   
  }

  final ShowLabManagerProfileUseCase showLabManagerProfileUseCase;

  Future<void> _onFetchRequested(
    LabManagerProfileFetchRequested event,
    Emitter<LabManagerProfileState> emit,
  ) async {
   
    if (state.status == LabManagerProfileStatus.loading) return;

    emit(
      state.copyWith(
        status: LabManagerProfileStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await showLabManagerProfileUseCase(
      const NoParameters(),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: LabManagerProfileStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: LabManagerProfileStatus.success,
            response: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}