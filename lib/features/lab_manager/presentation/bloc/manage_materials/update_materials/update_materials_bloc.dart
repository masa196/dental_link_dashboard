import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_materials/update_materials_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'update_materials_event.dart';
import 'update_materials_state.dart';

@injectable
class UpdateMaterialsBloc
    extends Bloc<UpdateMaterialsEvent, UpdateMaterialsState> {
  UpdateMaterialsBloc(
    this.updateMaterialsUsecase,
  ) : super(const UpdateMaterialsState()) {
    on<UpdateMaterialRequested>(_updateMaterial);
  }

  final UpdateMaterialsUsecase updateMaterialsUsecase;

  Future<void> _updateMaterial(
    UpdateMaterialRequested event,
    Emitter<UpdateMaterialsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result = await updateMaterialsUsecase(
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
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            success: true,
          ),
        );
      },
    );
  }
}