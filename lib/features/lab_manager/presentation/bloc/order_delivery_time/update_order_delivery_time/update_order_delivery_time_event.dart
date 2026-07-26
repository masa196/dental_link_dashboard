import 'package:dental_link_dashboard/features/lab_manager/domain/entities/order_delivery_time_entity/order_delivery_time_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateOrderDeliveryTimeEvent extends Equatable {
  const UpdateOrderDeliveryTimeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateOrderDeliveryTimeRequested
    extends UpdateOrderDeliveryTimeEvent {
  const UpdateOrderDeliveryTimeRequested({
    required this.parameters,
  });

  final OrderDeliveryTimeEntity parameters;

  @override
  List<Object?> get props => [parameters];
}