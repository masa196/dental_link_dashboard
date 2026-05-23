import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/edit_lab_manager/edit_lab_manager_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/edit_lab_manager/edit_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/edit_lab_manager_repository.dart';

@Injectable(as: EditLabManagerRepository)
class EditLabManagerRepositoryImpl implements EditLabManagerRepository {
  const EditLabManagerRepositoryImpl(this.remoteDataSource);

  final EditLabManagerRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    EditLabManagerEntity params,
  ) async {
    try {
      final response = await remoteDataSource.editLabManager(params);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log('EditLabManagerRepositoryImpl caught error: ${error.runtimeType}');
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
