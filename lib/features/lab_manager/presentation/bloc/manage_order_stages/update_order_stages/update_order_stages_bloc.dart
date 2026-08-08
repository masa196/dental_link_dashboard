import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'update_order_stages_event.dart';
import 'update_order_stages_state.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_order_stages/update_order_stages_usecase.dart';

@injectable
class UpdateOrderStagesBloc extends Bloc<
    UpdateOrderStagesEvent,
    UpdateOrderStagesState> {
  UpdateOrderStagesBloc(
    this._updateOrderStagesUsecase,
  ) : super(const UpdateOrderStagesState()) {
    on<UpdateOrderStagesRequested>(
      _onRequested,
    );

    on<UpdateOrderStagesStateReset>(
      _onReset,
    );
  }

  final UpdateOrderStagesUsecase
      _updateOrderStagesUsecase;

  Future<void> _onRequested(
    UpdateOrderStagesRequested event,
    Emitter<UpdateOrderStagesState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearFailure: true,
      ),
    );

    final result = await _updateOrderStagesUsecase(
      event.parameters,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            failure: failure,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            clearFailure: true,
          ),
        );
      },
    );
  }

  void _onReset(
    UpdateOrderStagesStateReset event,
    Emitter<UpdateOrderStagesState> emit,
  ) {
    emit(const UpdateOrderStagesState());
  }
}