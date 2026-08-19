import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/package/get_package_assigned_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


import 'get_package_assigned_event.dart';
import 'get_package_assigned_state.dart';

@injectable
class GetPackageAssignedBloc
    extends Bloc<GetPackageAssignedEvent, GetPackageAssignedState> {
  GetPackageAssignedBloc(
    this._getPackageAssignedUseCase,
  ) : super(const GetPackageAssignedState()) {
    on<GetPackageAssignedRequested>(
      _onGetPackageAssignedRequested,
    );
  }

  final GetPackageAssignedUseCase _getPackageAssignedUseCase;

  Future<void> _onGetPackageAssignedRequested(
    GetPackageAssignedRequested event,
    Emitter<GetPackageAssignedState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result = await _getPackageAssignedUseCase(
      const NoParameters(),
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
            data: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}