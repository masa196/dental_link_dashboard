import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/get_matrix_roles_and_permissions_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/matrix_roles_and_permissions_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_matrix_roles_and_permissions_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: GetMatrixRolesAndPermissionsRepository)
class GetMatrixRolesAndPermissionsRepositoryImpl
    implements GetMatrixRolesAndPermissionsRepository {
  const GetMatrixRolesAndPermissionsRepositoryImpl(this.remoteDataSource);

  final GetMatrixRolesAndPermissionsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, MatrixRolesResponse>> call() async {
    try {
      final response = await remoteDataSource.getMatrixRolesAndPermissions();
      return Right(response);
    } catch (error) {
      if (error is AppException) {
        return Left(AppErrorMapper.map(error));
      }

      if (error is DioException) {
        return Left(AppErrorMapper.map(AppException.fromDioException(error)));
      }

      return const Left(
        AppFailure(
          type: AppFailureType.unexpected,
          message: 'Something went wrong',
        ),
      );
    }
  }
}
