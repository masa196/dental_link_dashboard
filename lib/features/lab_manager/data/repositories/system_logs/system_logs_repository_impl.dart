import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/system_logs/system_logs_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/system_logs/system_logs_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/system_logs/system_logs_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/system_logs/system_logs_repository.dart';

@Injectable(as: SystemLogsRepository)
class SystemLogsRepositoryImpl implements SystemLogsRepository {
  const SystemLogsRepositoryImpl(this.remoteDataSource);

  final SystemLogsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, SystemLogsResponse>> call({
    required SystemLogsEntity parameters,
  }) async {
    try {
      final response = await remoteDataSource.getSystemLogs(
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
