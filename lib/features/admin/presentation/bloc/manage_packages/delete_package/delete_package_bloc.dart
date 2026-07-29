import 'package:dental_link_dashboard/features/admin/domain/usecases/manage_packages/delete_package_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'delete_package_event.dart';
import 'delete_package_state.dart';

@injectable
class DeletePackageBloc
    extends Bloc<DeletePackageEvent, DeletePackageState> {

  DeletePackageBloc(
    this.deletePackageUseCase,
  ) : super(const DeletePackageState()) {

    on<DeletePackageRequested>(_deletePackage);
  }

  final DeletePackageUseCase deletePackageUseCase;

  Future<void> _deletePackage(
    DeletePackageRequested event,
    Emitter<DeletePackageState> emit,
  ) async {

    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result = await deletePackageUseCase(
      event.packageId,
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
            success: response.success ?? true,
            message: response.message,
          ),
        );

      },
    );
  }
}