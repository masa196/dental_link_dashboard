import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/update_department/update_department_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/update_department_repository.dart';

@Injectable(as: UpdateDepartmentRepository)
class UpdateDepartmentRepositoryImpl implements UpdateDepartmentRepository {
  const UpdateDepartmentRepositoryImpl(this.remoteDataSource);

  final UpdateDepartmentRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    int departmentId,
    DepartmentNameEntity params,
  ) async {
    try {
      final response = await remoteDataSource.updateDepartment(
        departmentId,
        params,
      );
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'UpdateDepartmentRepositoryImpl caught error: ${error.runtimeType}',
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
