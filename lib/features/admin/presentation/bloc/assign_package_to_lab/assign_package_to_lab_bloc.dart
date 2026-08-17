import 'package:dental_link_dashboard/features/admin/domain/usecases/assign_package_to_lab/assign_package_to_lab_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'assign_package_to_lab_event.dart';
import 'assign_package_to_lab_state.dart';

@injectable
class AssignPackageToLabBloc
    extends Bloc<
        AssignPackageToLabEvent,
        AssignPackageToLabState> {
  AssignPackageToLabBloc(
    this._assignPackageToLabUsecase,
  ) : super(const AssignPackageToLabState()) {
    on<AssignPackageToLabRequested>(
      _onAssignPackageToLabRequested,
    );
  }

  final AssignPackageToLabUsecase _assignPackageToLabUsecase;

  Future<void> _onAssignPackageToLabRequested(
    AssignPackageToLabRequested event,
    Emitter<AssignPackageToLabState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
        clearResponse: true,
      ),
    );

    final result = await _assignPackageToLabUsecase(
      event.parameters,
    );

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
            response: response,
          ),
        );
      },
    );
  }
}