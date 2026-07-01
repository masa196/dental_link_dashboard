import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';

abstract class CreateDepartmentsBlocEvent extends Equatable {
  const CreateDepartmentsBlocEvent();

  @override
  List<Object?> get props => [];
}

class CreateDepartmentsSubmitted extends CreateDepartmentsBlocEvent {
  const CreateDepartmentsSubmitted({required this.params});

  final DepartmentsEntity params;

  @override
  List<Object?> get props => [params];
}

class CreateDepartmentsReset extends CreateDepartmentsBlocEvent {
  const CreateDepartmentsReset();
}
