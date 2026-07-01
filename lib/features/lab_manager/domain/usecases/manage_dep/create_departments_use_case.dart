import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/create_departments_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';


@injectable
class CreateDepartmentsUseCase {
  const CreateDepartmentsUseCase(this.repository);

  final CreateDepartmentsRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(DepartmentsEntity params) {
    return repository.call(params);
  }
}
