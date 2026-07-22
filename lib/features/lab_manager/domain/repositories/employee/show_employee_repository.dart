import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_pagination_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_employee/show_employee_model.dart';

abstract interface class ShowEmployeeRepository {
  Future<Either<AppFailure, ShowEmployeeResponse>> call({
    required EmployeePaginationEntity parameters,
  });
}
