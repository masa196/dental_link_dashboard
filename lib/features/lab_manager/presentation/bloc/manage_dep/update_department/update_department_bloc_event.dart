import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';

abstract class UpdateDepartmentBlocEvent extends Equatable {
  const UpdateDepartmentBlocEvent();

  @override
  List<Object?> get props => [];
}

class UpdateDepartmentSubmitted extends UpdateDepartmentBlocEvent {
  const UpdateDepartmentSubmitted({
    required this.departmentId,
    required this.params,
  });

  final int departmentId;
  final DepartmentNameEntity params;

  @override
  List<Object?> get props => [departmentId, params];
}

class UpdateDepartmentReset extends UpdateDepartmentBlocEvent {
  const UpdateDepartmentReset();
}
