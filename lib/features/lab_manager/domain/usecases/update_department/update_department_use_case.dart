import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/update_department_repository.dart';

@injectable
class UpdateDepartmentUseCase {
  const UpdateDepartmentUseCase(this.repository);

  final UpdateDepartmentRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(
    int departmentId,
    DepartmentNameEntity params,
  ) {
    return repository.call(departmentId, params);
  }
}
