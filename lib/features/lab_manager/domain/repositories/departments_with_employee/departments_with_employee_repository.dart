import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';

abstract interface class DepartmentsWithEmployeeRepository {
  Future<Either<AppFailure, DepartmentsWithEmployeeResponse>> call();
}
