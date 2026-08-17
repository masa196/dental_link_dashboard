import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/manage_packages/update_package/update_package_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/update_package_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_packages/update_package_repository.dart';


import 'package:injectable/injectable.dart';

@Injectable(as: UpdatePackageRepository)
class UpdatePackagesRepositoryImpl
    implements UpdatePackageRepository {
  const UpdatePackagesRepositoryImpl(
    this._remoteDataSource,
  );

  final UpdatePackageRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required UpdatePackageEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.updatePackage(
        parameters: parameters,
      );

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}