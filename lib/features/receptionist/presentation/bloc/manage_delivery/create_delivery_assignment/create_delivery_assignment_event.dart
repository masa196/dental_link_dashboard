import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/create_delivery_assignment_entity.dart';

abstract class CreateDeliveryAssignmentEvent extends Equatable {
  const CreateDeliveryAssignmentEvent();

  @override
  List<Object?> get props => [];
}

class CreateDeliveryAssignmentRequested extends CreateDeliveryAssignmentEvent {
  final CreateDeliveryAssignmentEntity entity;

  const CreateDeliveryAssignmentRequested(this.entity);

  @override
  List<Object?> get props => [entity];
}