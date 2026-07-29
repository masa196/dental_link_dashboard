import 'package:dental_link_dashboard/features/admin/domain/usecases/manage_packages/update_package_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'update_package_event.dart';
import 'update_package_state.dart';

@injectable
class UpdatePackageBloc extends Bloc<UpdatePackageEvent, UpdatePackageState> {
  UpdatePackageBloc(this.updatePackageUsecase)
    : super(const UpdatePackageState()) {
    on<UpdatePackageRequested>(_updatePackage);
  }

  final UpdatePackageUsecase updatePackageUsecase;

  Future<void> _updatePackage(
    UpdatePackageRequested event,
    Emitter<UpdatePackageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearFailure: true));

    final result = await updatePackageUsecase(event.parameters);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, failure: failure));
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            success: response.success ?? true,
            message: response.message,
          ),
        );
      },
    );
  }
}
