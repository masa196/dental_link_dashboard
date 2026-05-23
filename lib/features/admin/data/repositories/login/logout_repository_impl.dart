import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/login/login_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/logout/logout_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/logout_repository.dart';

@Injectable(as: LogoutRepository)
class LogoutRepositoryImpl implements LogoutRepository {
  const LogoutRepositoryImpl(this.remoteDataSource);

  final LoginRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, LogoutResponseModel>> call(String token) async {
    try {
      final model = await remoteDataSource.logout(token);
      return Right(model);
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
