import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/matrix_roles_entity/matrix_roles_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/update_matrix_roles_and_permissions_repository.dart';

@injectable
class UpdateMatrixRolesAndPermissionsUseCase {
  const UpdateMatrixRolesAndPermissionsUseCase(this.repository);

  final UpdateMatrixRolesAndPermissionsRepository repository;
  Future<Either<AppFailure, BaseResponseModel>> call(MatrixRolesEntity params) {
    return repository.call(params);
  }
}