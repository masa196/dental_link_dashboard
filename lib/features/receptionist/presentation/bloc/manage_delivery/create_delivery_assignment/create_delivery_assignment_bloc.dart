import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_delivery/create_delivery_assignment_usecase.dart';

import 'create_delivery_assignment_event.dart';
import 'create_delivery_assignment_state.dart';

@injectable
class CreateDeliveryAssignmentBloc extends Bloc<
    CreateDeliveryAssignmentEvent,
    CreateDeliveryAssignmentState> {

  final CreateDeliveryAssignmentUsecase _usecase;

  CreateDeliveryAssignmentBloc(this._usecase)
      : super(const CreateDeliveryAssignmentState()) {

    on<CreateDeliveryAssignmentRequested>(_onCreate);
  }

  Future<void> _onCreate(
    CreateDeliveryAssignmentRequested event,
    Emitter<CreateDeliveryAssignmentState> emit,
  ) async {

    emit(state.copyWith(
      status: CreateDeliveryAssignmentStatus.loading,
    ));

    final result = await _usecase(event.entity);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CreateDeliveryAssignmentStatus.failure,
          failure: failure,
        ));
      },
      (response) {
        /// ✅ نفس أسلوب UpdateOrderStatus (بدون أي logic إضافي)
        emit(state.copyWith(
          status: CreateDeliveryAssignmentStatus.success,
          response: response,
        ));
      },
    );
  }
}