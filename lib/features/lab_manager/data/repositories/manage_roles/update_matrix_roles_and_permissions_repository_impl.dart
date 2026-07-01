import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/matrix_roles_entity/matrix_roles_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/update_matrix_roles_and_permissions_repository.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/update_matrix_roles_and_permissions_remote_data_source.dart';

@LazySingleton(as: UpdateMatrixRolesAndPermissionsRepository)
class UpdateMatrixRolesAndPermissionsRepositoryImpl
    implements UpdateMatrixRolesAndPermissionsRepository {
  final UpdateMatrixRolesAndPermissionsRemoteDataSource remoteDataSource;

  const UpdateMatrixRolesAndPermissionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    MatrixRolesEntity params,
  ) async {
    try {
      final response = await remoteDataSource.updateMatrix(params);

      return Right(BaseResponseModel.fromJson(response));
    } catch (error) {
      return Left(AppErrorMapper.map(error));
    }
  }
}