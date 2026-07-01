import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';

abstract interface class UpdateEmployeeRepository {
  
  Future<Either<AppFailure, BaseResponseModel>> call(EmployeeEntity params);
}