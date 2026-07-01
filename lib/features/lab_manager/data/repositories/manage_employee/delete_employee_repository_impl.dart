import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_employee/delete_employee_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/delete_employee_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';



@Injectable(as: DeleteEmployeeRepository)
class DeleteEmployeeRepositoryImpl implements DeleteEmployeeRepository {
  const DeleteEmployeeRepositoryImpl(this.remoteDataSource);
  final DeleteEmployeeRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(int employeeId) async {
    try {
      final response = await remoteDataSource.deleteEmployee(employeeId);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'DeleteEmployeeRepositoryImpl caught error: ${error.runtimeType}',
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
