import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/update_employee_repository.dart';

@injectable
class UpdateEmployeeUseCase {
  const UpdateEmployeeUseCase(this.repository);

  final UpdateEmployeeRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(EmployeeEntity params) {
    return repository.call(params);
  }
}
