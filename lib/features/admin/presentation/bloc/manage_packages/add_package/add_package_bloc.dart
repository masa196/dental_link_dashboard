import 'package:dental_link_dashboard/features/admin/domain/usecases/manage_packages/add_package_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'add_package_event.dart';
import 'add_package_state.dart';

@injectable
class AddPackageBloc extends Bloc<AddPackageEvent, AddPackageState> {
  AddPackageBloc(this.addPackageUsecase) : super(const AddPackageState()) {
    on<AddPackageRequested>(_addPackage);
  }

  final AddPackageUsecase addPackageUsecase;

  Future<void> _addPackage(
    AddPackageRequested event,
    Emitter<AddPackageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearFailure: true));

    final result = await addPackageUsecase(event.parameters);

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
