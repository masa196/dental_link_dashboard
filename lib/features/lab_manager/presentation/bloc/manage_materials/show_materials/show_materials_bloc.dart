import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/show_materials_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_materials/show_materials_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'show_materials_event.dart';
import 'show_materials_state.dart';



@injectable
class ShowMaterialsBloc
    extends Bloc<ShowMaterialsEvent, ShowMaterialsState> {
  ShowMaterialsBloc(this._showMaterialsUsecase)
      : super(const ShowMaterialsState()) {
    on<ShowMaterialsRequested>(_onRequested);
    on<ShowMaterialsRefresh>(_onRefresh);
  }

  final ShowMaterialsUsecase _showMaterialsUsecase;

  Future<void> _onRequested(
    ShowMaterialsRequested event,
    Emitter<ShowMaterialsState> emit,
  ) async {
    final search = event.search ?? state.currentSearch;

    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
        currentSearch: search,
      ),
    );

    final result = await _showMaterialsUsecase(
      ShowMaterialsEntity(
        page: event.page,
        perPage: event.perPage,
        search: search,
      ),
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
      final materials = response.data?.data ?? [];
     
        if (materials.isEmpty && event.page > 1) {
          add(
            ShowMaterialsRequested(
              page: event.page - 1,
              perPage: event.perPage,
              search: search,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            materials: materials,
            currentPage:
    response.data?.currentPage ?? event.page,
lastPage:
    response.data?.lastPage ?? 1,
            currentSearch: search,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    ShowMaterialsRefresh event,
    Emitter<ShowMaterialsState> emit,
  ) async {
    add(
      ShowMaterialsRequested(
        page: state.currentPage,
        search: state.currentSearch,
      ),
    );
  }
}