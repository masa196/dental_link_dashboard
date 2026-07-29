import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/manage_packages/show_packages/show_packages_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/show_package_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_materials/show_packages_repository.dart';



import 'package:injectable/injectable.dart';

@Injectable(as: ShowPackagesRepository)
class ShowPackagesRepositoryImpl
    implements ShowPackagesRepository {
  const ShowPackagesRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowPackagesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, PackagesResponse>> call({
    required ShowPackagesEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.getPackages(
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