import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/create_departments_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/create_departments/create_departments_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';


@Injectable(as: CreateDepartmentsRepository)
class CreateDepartmentsRepositoryImpl
    implements CreateDepartmentsRepository {
  const CreateDepartmentsRepositoryImpl(this.remoteDataSource);

  final CreateDepartmentsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    DepartmentsEntity params,
  ) async {
    try {
      final response = await remoteDataSource.createDepartments(params);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'CreateDepartmentsBulkRepositoryImpl caught error: ${error.runtimeType}',
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
