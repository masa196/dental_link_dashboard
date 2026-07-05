import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/update_order_status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateOrderStatusEvent extends Equatable {
  const UpdateOrderStatusEvent();

  @override
  List<Object?> get props => [];
}

class UpdateOrderStatusRequested extends UpdateOrderStatusEvent {
  const UpdateOrderStatusRequested(this.parameters);

  final UpdateOrderStatusEntity parameters;

  @override
  List<Object?> get props => [parameters];
}