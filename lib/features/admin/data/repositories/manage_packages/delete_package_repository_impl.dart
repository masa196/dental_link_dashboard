import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/manage_packages/delete_package/delete_materials_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_packages/delete_package_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';


@Injectable(as: DeletePackageRepository)
class DeletePackageRepositoryImpl implements DeletePackageRepository {
  const DeletePackageRepositoryImpl(this.remoteDataSource);

  final DeletePackageRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(int packageId) async {
    try {
      final response = await remoteDataSource.deletePackage(packageId);
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
