import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/matrix_roles_and_permissions_model.dart';

import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';

import '../../repositories/manage_roles/get_matrix_roles_and_permissions_repository.dart';


@injectable
class GetMatrixRolesAndPermissionsUseCase
    extends BaseUseCase<MatrixRolesResponse, NoParameters> {
  final GetMatrixRolesAndPermissionsRepository repository;

  GetMatrixRolesAndPermissionsUseCase(this.repository);

  @override
  Future<Either<AppFailure, MatrixRolesResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
