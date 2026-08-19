import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/package/package_assigned_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/package/package_assigned_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/package/package_assigned_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PackageAssignedRepository)
class PackageAssignedRepositoryImpl
    implements PackageAssignedRepository {
  const PackageAssignedRepositoryImpl(
    this._remoteDataSource,
  );

  final PackageAssignedRemoteDataSource
      _remoteDataSource;

  @override
  Future<Either<AppFailure, PackageAssignedResponse>>
      call() async {
    try {
      final response =
          await _remoteDataSource.getPackageAssigned();

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
  
}