import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/delete_lab_manager/delete_lab_manager_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/delete_lab_manager/delete_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/delete_lab_manager_repository.dart';

@Injectable(as: DeleteLabManagerRepository)
class DeleteLabManagerRepositoryImpl implements DeleteLabManagerRepository {
  const DeleteLabManagerRepositoryImpl(this.remoteDataSource);

  final DeleteLabManagerRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    DeleteLabManagerEntity params,
  ) async {
    try {
      final response = await remoteDataSource.deleteLabManager(params);
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
