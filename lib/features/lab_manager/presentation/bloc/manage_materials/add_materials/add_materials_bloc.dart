import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_materials/add_materials_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'add_materials_event.dart';
import 'add_materials_state.dart';


@injectable
class AddMaterialsBloc
    extends Bloc<AddMaterialsEvent, AddMaterialsState> {

  AddMaterialsBloc(
    this.addMaterialsUsecase,
  ) : super(const AddMaterialsState()) {

    on<AddMaterialRequested>(_addMaterial);
  }


  final AddMaterialsUsecase addMaterialsUsecase;


  Future<void> _addMaterial(
    AddMaterialRequested event,
    Emitter<AddMaterialsState> emit,
  ) async {

    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );


    final result = await addMaterialsUsecase(
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