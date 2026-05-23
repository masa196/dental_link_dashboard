import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/departments_with_employee/departments_with_employee_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/departments_with_employee_repository.dart';

@Injectable(as: DepartmentsWithEmployeeRepository)
class DepartmentsWithEmployeeRepositoryImpl
    implements DepartmentsWithEmployeeRepository {
  const DepartmentsWithEmployeeRepositoryImpl(this.remoteDataSource);

  final DepartmentsWithEmployeeRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, DepartmentsWithEmployeeResponse>> call() async {
    try {
      final response = await remoteDataSource.getDepartmentsWithEmployees();
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
