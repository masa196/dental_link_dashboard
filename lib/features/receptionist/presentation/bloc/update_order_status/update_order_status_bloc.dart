import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/lock_order_usecase.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/unlock_order_usecase.dart';
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
  this._lockOrderUsecase,
  this._unlockOrderUsecase,
) : super(const UpdateOrderStatusState()) {
   on<LockOrderRequested>(
    _onLockRequested,
);

on<UnlockOrderRequested>(
    _onUnlockRequested,
);

on<UpdateOrderStatusRequested>(
    _onUpdateOrderStatusRequested,
);
  }

  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  final LockOrderUsecase _lockOrderUsecase;
  final UnLockOrderUsecase _unlockOrderUsecase;

Future<void> _onUpdateOrderStatusRequested(
  UpdateOrderStatusRequested event,
  Emitter<UpdateOrderStatusState> emit,
) async {

  emit(
    state.copyWith(
      status: UpdateOrderStatusStatus.loading,
    ),
  );

  final result =
      await _updateOrderStatusUseCase(event.parameters);

  await result.fold(

    (failure) async {

      emit(
        state.copyWith(
          status: UpdateOrderStatusStatus.failure,
          failure: failure,
        ),
      );

    },

    (response) async {

      //-------------------------------------------------
      // Unlock
      //-------------------------------------------------

      await _unlockOrderUsecase(
        event.parameters.orderId,
      );

      emit(
        state.copyWith(
          status: UpdateOrderStatusStatus.success,
          response: response,
        ),
      );

    },

  );

}

  Future<void> _onLockRequested(
  LockOrderRequested event,
  Emitter<UpdateOrderStatusState> emit,
) async {

 emit(
  const UpdateOrderStatusState(
    status: UpdateOrderStatusStatus.locking,
  ).copyWith(
    orderId: event.orderId,
  ),
);

  final result =
      await _lockOrderUsecase(event.orderId);

  result.fold(

    (failure){

      emit(
        state.copyWith(
          status: UpdateOrderStatusStatus.failure,
          failure: failure,
        ),
      );

    },

    (response){

      emit(
        state.copyWith(
          status: UpdateOrderStatusStatus.locked,
          response: response,
        ),
      );

    },

  );

}

Future<void> _onUnlockRequested(
  UnlockOrderRequested event,
  Emitter<UpdateOrderStatusState> emit,
) async {

  await _unlockOrderUsecase(event.orderId);

}
}