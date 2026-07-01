import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/delete_department_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';


@injectable
class DeleteDepartmentUseCase {
  const DeleteDepartmentUseCase(this.repository);
  final DeleteDepartmentRepository repository;
  Future<Either<AppFailure, BaseResponseModel>> call(int departmentId) {
    return repository.call(departmentId);
  }
}
