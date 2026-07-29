import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/manage_packages/add_package/add_package_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/add_packages_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_materials/add_package_repository.dart';



import 'package:injectable/injectable.dart';


@Injectable(as: AddPackageRepository)
class AddPackageRepositoryImpl
    implements AddPackageRepository {
  const AddPackageRepositoryImpl(
    this._remoteDataSource,
  );

  final AddPackageRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required AddPackageEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.addPackage(
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