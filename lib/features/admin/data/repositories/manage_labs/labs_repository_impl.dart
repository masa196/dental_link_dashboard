import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/manage_labs/labs_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/labs_repository.dart';

@Injectable(as: LabsRepository)
class LabsRepositoryImpl implements LabsRepository {
  const LabsRepositoryImpl(this.remoteDataSource);

  final LabsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, PaginatedLabsResponseModel>> getLabs(
    LabsQueryParams params,
  ) async {
    try {
      final response = await remoteDataSource.getLabs(params);
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
