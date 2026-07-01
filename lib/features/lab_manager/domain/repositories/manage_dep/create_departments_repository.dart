import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';

abstract interface class CreateDepartmentsRepository {
  Future<Either<AppFailure, BaseResponseModel>> call(DepartmentsEntity params);
}
