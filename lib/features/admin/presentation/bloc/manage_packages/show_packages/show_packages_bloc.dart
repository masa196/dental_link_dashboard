import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/show_package_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/manage_packages/show_packages_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'show_packages_event.dart';
import 'show_packages_state.dart';



@injectable
class ShowPackagesBloc
    extends Bloc<ShowPackagesEvent, ShowPackagesState> {
  ShowPackagesBloc(this._showPackagesUsecase)
      : super(const ShowPackagesState()) {
    on<ShowPackagesRequested>(_onRequested);
    on<ShowPackagesRefresh>(_onRefresh);
  }

  final ShowPackagesUsecase _showPackagesUsecase;

  Future<void> _onRequested(
    ShowPackagesRequested event,
    Emitter<ShowPackagesState> emit,
  ) async {
    final search = event.search ?? state.currentSearch;

    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
        currentSearch: search,
      ),
    );

    final result = await _showPackagesUsecase(
      ShowPackagesEntity(
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
      final packages = response.data?.data ?? [];
     
        if (packages.isEmpty && event.page > 1) {
          add(
            ShowPackagesRequested(
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
            packages: packages,
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
    ShowPackagesRefresh event,
    Emitter<ShowPackagesState> emit,
  ) async {
    add(
      ShowPackagesRequested(
        page: state.currentPage,
        search: state.currentSearch,
      ),
    );
  }
}