import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'get_order_stages_event.dart';
import 'get_order_stages_state.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_order_stages/get_order_stages_usecase.dart';

@injectable
class GetOrderStagesBloc
    extends Bloc<
        GetOrderStagesEvent,
        GetOrderStagesState> {
  GetOrderStagesBloc(
    this._getOrderStagesUseCase,
  ) : super(const GetOrderStagesState()) {
    on<GetOrderStagesRequested>(
      _onRequested,
    );

    on<GetOrderStagesRefreshed>(
      _onRequested,
    );
  }

  final GetOrderStagesUseCase
      _getOrderStagesUseCase;

  Future<void> _onRequested(
    GetOrderStagesEvent event,
    Emitter<GetOrderStagesState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result =
        await _getOrderStagesUseCase(
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
            response: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}