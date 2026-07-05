import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/update_order_status_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'update_order_status_event.dart';
import 'update_order_status_state.dart';

@injectable
class UpdateOrderStatusBloc
    extends Bloc<UpdateOrderStatusEvent, UpdateOrderStatusState> {
  UpdateOrderStatusBloc(
    this._updateOrderStatusUseCase,
  ) : super(const UpdateOrderStatusState()) {
    on<UpdateOrderStatusRequested>(
      _onUpdateOrderStatusRequested,
    );
  }

  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;

  Future<void> _onUpdateOrderStatusRequested(
    UpdateOrderStatusRequested event,
    Emitter<UpdateOrderStatusState> emit,
  ) async {
    emit(
      state.copyWith(
        status: UpdateOrderStatusStatus.loading,
      ),
    );

    final result = await _updateOrderStatusUseCase(
      event.parameters,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: UpdateOrderStatusStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: UpdateOrderStatusStatus.success,
            response: response,
          ),
        );
      },
    );
  }
}