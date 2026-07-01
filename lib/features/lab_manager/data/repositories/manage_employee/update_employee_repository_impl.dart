import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_employee/update_employee_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/update_employee_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';

@Injectable(as: UpdateEmployeeRepository)
class UpdateEmployeeRepositoryImpl implements UpdateEmployeeRepository {
  const UpdateEmployeeRepositoryImpl(this.remoteDataSource);

  final UpdateEmployeeRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(EmployeeEntity params) async {
    try {
      // تمرير الـ params مباشرة للـ DataSource
      final response = await remoteDataSource.updateEmployee(params);
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