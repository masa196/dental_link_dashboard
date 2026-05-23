import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/login/login_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/login_entity.dart';
import 'package:dental_link_dashboard/features/admin/data/models/login/login_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  const LoginRepositoryImpl(this.remoteDataSource);

  final LoginRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, LoginResponseModel>> call(
    LoginEntity params,
  ) async {
    try {
      final response = await remoteDataSource.login(params);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log('LoginRepositoryImpl caught error: ${error.runtimeType}');
        log(error.toString());
        log(stackTrace.toString());
      } catch (_) {}

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
