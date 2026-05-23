import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_employee/show_employee_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_pagination_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/show_employee_repository.dart';

@injectable
class GetShowEmployeeUseCase
    extends BaseUseCase<ShowEmployeeResponse, EmployeePaginationEntity> {
  GetShowEmployeeUseCase(this.repository);

  final ShowEmployeeRepository repository;

  @override
  Future<Either<AppFailure, ShowEmployeeResponse>> call(
    EmployeePaginationEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
