import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/get_roles_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/roles/roles_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_roles_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: GetRolesRepository)
class GetRolesRepositoryImpl
    implements GetRolesRepository {
  const GetRolesRepositoryImpl(this.remoteDataSource);

  final GetRolesRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, RolesResponse>> call() async {
    try {
      final response = await remoteDataSource.getRoles();
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
