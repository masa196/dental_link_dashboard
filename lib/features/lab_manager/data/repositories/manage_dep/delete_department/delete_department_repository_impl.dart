import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/delete_department/delete_department_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/delete_department_repository.dart';

@Injectable(as: DeleteDepartmentRepository)
class DeleteDepartmentRepositoryImpl implements DeleteDepartmentRepository {
  const DeleteDepartmentRepositoryImpl(this.remoteDataSource);

  final DeleteDepartmentRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(int departmentId) async {
    try {
      final response = await remoteDataSource.deleteDepartment(departmentId);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'DeleteDepartmentRepositoryImpl caught error: ${error.runtimeType}',
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
