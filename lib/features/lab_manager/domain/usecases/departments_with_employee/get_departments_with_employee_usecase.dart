import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/departments_with_employee_repository.dart';

@injectable
class GetDepartmentsWithEmployeeUseCase
    extends BaseUseCase<DepartmentsWithEmployeeResponse, NoParameters> {
  final DepartmentsWithEmployeeRepository repository;

  GetDepartmentsWithEmployeeUseCase(this.repository);

  @override
  Future<Either<AppFailure, DepartmentsWithEmployeeResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
