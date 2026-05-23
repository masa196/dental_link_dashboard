import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/create_lab_manager/create_lab_manager_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/create_lab_manager_repository.dart';

@Injectable(as: CreateLabManagerRepository)
class CreateLabManagerRepositoryImpl implements CreateLabManagerRepository {
  const CreateLabManagerRepositoryImpl(this.remoteDataSource);

  final CreateLabManagerRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    CreateLabManagerEntity params,
  ) async {
    try {
      final response = await remoteDataSource.createLabManager(params);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'CreateLabManagerRepositoryImpl caught error: ${error.runtimeType}',
        );
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
