import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_materials/delete_materials/delete_materials_remote_data_source.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/delete_materials_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';



@Injectable(as: DeleteMaterialsRepository)
class DeleteMaterialsRepositoryImpl implements DeleteMaterialsRepository {
  const DeleteMaterialsRepositoryImpl(this.remoteDataSource);

  final DeleteMaterialsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(int materialId) async {
    try {
      final response = await remoteDataSource.deleteMaterial(materialId);
      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'DeleteMaterialsRepositoryImpl caught error: ${error.runtimeType}',
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
