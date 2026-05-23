import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/delete_lab_manager/delete_lab_manager_entity.dart';

abstract interface class DeleteLabManagerRepository {
  Future<Either<AppFailure, BaseResponseModel>> call(
    DeleteLabManagerEntity params,
  );
}
