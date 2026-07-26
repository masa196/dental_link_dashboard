import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/order_delivery_time/get_order_delivery_time_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'get_order_delivery_time_event.dart';
import 'get_order_delivery_time_state.dart';

@injectable
class GetOrderDeliveryTimeBloc extends Bloc<
    GetOrderDeliveryTimeEvent,
    GetOrderDeliveryTimeState> {
  GetOrderDeliveryTimeBloc(
    this._getOrderDeliveryTimeUseCase,
  ) : super(const GetOrderDeliveryTimeState()) {
    on<GetOrderDeliveryTimeRequested>(_onRequested);
    on<GetOrderDeliveryTimeRefresh>(_onRefresh);
  }

  final GetOrderDeliveryTimeUseCase _getOrderDeliveryTimeUseCase;

  Future<void> _onRequested(
    GetOrderDeliveryTimeRequested event,
    Emitter<GetOrderDeliveryTimeState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
      ),
    );

    final result =
        await _getOrderDeliveryTimeUseCase(
      NoParameters(),
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
            deliveryTime: response.data,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    GetOrderDeliveryTimeRefresh event,
    Emitter<GetOrderDeliveryTimeState> emit,
  ) async {
    add(
      const GetOrderDeliveryTimeRequested(),
    );
  }
}