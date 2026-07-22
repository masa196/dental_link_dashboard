import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/show_employee/show_employee_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_employee/show_employee_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_pagination_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/employee/show_employee_repository.dart';

@Injectable(as: ShowEmployeeRepository)
class ShowEmployeeRepositoryImpl implements ShowEmployeeRepository {
  const ShowEmployeeRepositoryImpl(this.remoteDataSource);

  final ShowEmployeeRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, ShowEmployeeResponse>> call({
    required EmployeePaginationEntity parameters,
  }) async {
    try {
      final response = await remoteDataSource.getShowEmployee(
        parameters: parameters,
      );
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
