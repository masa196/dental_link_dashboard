import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/assign_package_to_lab/assign_package_to_lab_entity.dart';

abstract interface class AssignPackageToLabRepository {
  Future<Either<AppFailure, BaseResponseModel>> assignPackageToLab(
    AssignPackageToLabEntity entity,
  );
}