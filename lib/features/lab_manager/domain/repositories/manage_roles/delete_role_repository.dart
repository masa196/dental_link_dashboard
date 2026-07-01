import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

abstract interface class DeleteRoleRepository {
  Future<Either<AppFailure, BaseResponseModel>> call(int roleId);
}
