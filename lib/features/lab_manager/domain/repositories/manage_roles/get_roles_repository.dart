import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/roles/roles_model.dart';

abstract interface class GetRolesRepository {
  Future<Either<AppFailure, RolesResponse>> call();
}
