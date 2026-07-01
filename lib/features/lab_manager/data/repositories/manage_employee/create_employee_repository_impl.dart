import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_employee/create_employee_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/create_employee_repository.dart';

@Injectable(as: CreateEmployeeRepository)
class CreateEmployeeRepositoryImpl implements CreateEmployeeRepository {
  const CreateEmployeeRepositoryImpl(this.remoteDataSource);

  final CreateEmployeeRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    EmployeeEntity params,
  ) async {
    try {
      final response = await remoteDataSource.createEmployee(params);
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
