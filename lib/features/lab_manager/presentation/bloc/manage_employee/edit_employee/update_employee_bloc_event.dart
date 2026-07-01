import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';

abstract class UpdateEmployeeEvent extends Equatable {
  const UpdateEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateEmployeeSubmitted extends UpdateEmployeeEvent {
  const UpdateEmployeeSubmitted(this.params);

  final EmployeeEntity params;

  @override
  List<Object?> get props => [params];
}

class UpdateEmployeeReset extends UpdateEmployeeEvent {
  const UpdateEmployeeReset();
}