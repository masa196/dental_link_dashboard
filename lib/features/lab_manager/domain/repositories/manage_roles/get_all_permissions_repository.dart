import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/all_permissions_model.dart';


abstract interface class GetAllPermissionsRepository {
  Future<Either<AppFailure, AllPermissionsResponse>> call();
}
