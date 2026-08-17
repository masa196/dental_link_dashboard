import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/lab_statistics/lab_statistics_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/lab_statistics/lab_statistics_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/lab_statistics/lab_statistics_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: LabStatisticsRepository)
class LabStatisticsRepositoryImpl implements LabStatisticsRepository {
  
  const LabStatisticsRepositoryImpl(this.remoteDataSource);

  final LabStatisticsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, LabStatisticsResponse>> call() async {
    try {
      final response = await remoteDataSource.getLabStatistics();
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
