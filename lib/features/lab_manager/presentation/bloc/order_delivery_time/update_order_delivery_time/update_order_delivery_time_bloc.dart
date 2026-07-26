import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/order_delivery_time/update_order_delivery_time_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'update_order_delivery_time_event.dart';
import 'update_order_delivery_time_state.dart';

@injectable
class UpdateOrderDeliveryTimeBloc extends Bloc<
    UpdateOrderDeliveryTimeEvent,
    UpdateOrderDeliveryTimeState> {
  UpdateOrderDeliveryTimeBloc(
    this._updateOrderDeliveryTimeUsecase,
  ) : super(const UpdateOrderDeliveryTimeState()) {
    on<UpdateOrderDeliveryTimeRequested>(_onRequested);
  }

  final UpdateOrderDeliveryTimeUsecase
      _updateOrderDeliveryTimeUsecase;

  Future<void> _onRequested(
    UpdateOrderDeliveryTimeRequested event,
    Emitter<UpdateOrderDeliveryTimeState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
        isSuccess: false,
      ),
    );

    final result =
        await _updateOrderDeliveryTimeUsecase(
      event.parameters,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            failure: failure,
            isSuccess: false,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            response: response,
            isSuccess: true,
          ),
        );
      },
    );
  }
}