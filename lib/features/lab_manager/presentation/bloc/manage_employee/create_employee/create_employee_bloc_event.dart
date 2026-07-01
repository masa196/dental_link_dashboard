import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';

abstract class CreateEmployeeEvent extends Equatable {
  const CreateEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class CreateEmployeeSubmitted extends CreateEmployeeEvent {
  const CreateEmployeeSubmitted(this.params);

  final EmployeeEntity params;

  @override
  List<Object?> get props => [params];
}

class CreateEmployeeReset extends CreateEmployeeEvent {
  const CreateEmployeeReset();
}
