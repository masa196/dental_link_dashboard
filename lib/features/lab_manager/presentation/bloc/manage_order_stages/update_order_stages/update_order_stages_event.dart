import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_order_stages/order_stages_entity.dart';

sealed class UpdateOrderStagesEvent extends Equatable {
  const UpdateOrderStagesEvent();

  @override
  List<Object?> get props => [];
}

final class UpdateOrderStagesRequested
    extends UpdateOrderStagesEvent {
  const UpdateOrderStagesRequested({
    required this.parameters,
  });

  final OrderStagesEntity parameters;

  @override
  List<Object?> get props => [parameters];
}

final class UpdateOrderStagesStateReset
    extends UpdateOrderStagesEvent {
  const UpdateOrderStagesStateReset();
}