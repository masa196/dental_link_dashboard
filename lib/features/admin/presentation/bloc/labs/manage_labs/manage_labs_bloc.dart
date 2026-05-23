 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/manage_labs/get_labs_usecase.dart';

import 'manage_labs_bloc_event.dart';
import 'manage_labs_bloc_state.dart';

@injectable
class ManageLabsBloc extends Bloc<ManageLabsBlocEvent, ManageLabsBlocState> {
  ManageLabsBloc({
    required this.getLabsUseCase,
  }) : super(const ManageLabsBlocState()) {
    on<ManageLabsFetchRequested>(_onFetchRequested);

    add(
      const ManageLabsFetchRequested(
        tab: LabsTabType.active,
        page: 1,
        perPage: _defaultPageSize,
      ),
    );
  }

  static const int _defaultPageSize = 15;

  final GetLabsUseCase getLabsUseCase;

  Future<void> _onFetchRequested(
    ManageLabsFetchRequested event,
    Emitter<ManageLabsBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ManageLabsRemoteStatus.loading,
        tab: event.tab,
        clearFailureMessage: true,
      ),
    );

    final result = await getLabsUseCase(
      LabsQueryParams(
        tab: event.tab,
        page: event.page,
        perPage: event.perPage,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ManageLabsRemoteStatus.failure,
            failureMessage: failure.message,
            tab: event.tab,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: ManageLabsRemoteStatus.success,
            page: response,
            tab: event.tab,
            clearFailureMessage: true,
          ),
        );
      },
    );
  }
}