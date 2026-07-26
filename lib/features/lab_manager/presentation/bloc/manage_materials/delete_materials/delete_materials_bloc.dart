import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_materials/delete_materials_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'delete_materials_event.dart';
import 'delete_materials_state.dart';

@injectable
class DeleteMaterialsBloc
    extends Bloc<DeleteMaterialsEvent, DeleteMaterialsState> {

  DeleteMaterialsBloc(
    this.deleteMaterialsUseCase,
  ) : super(const DeleteMaterialsState()) {

    on<DeleteMaterialRequested>(_deleteMaterial);
  }

  final DeleteMaterialsUseCase deleteMaterialsUseCase;

  Future<void> _deleteMaterial(
    DeleteMaterialRequested event,
    Emitter<DeleteMaterialsState> emit,
  ) async {

    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result = await deleteMaterialsUseCase(
      event.materialId,
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