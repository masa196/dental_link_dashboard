import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/package_hisrtory_sys_admin.dart/show_hisrtory_sys_admin_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/package_history_sys_admin/package_history_sys_admin_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShowPackageHistorySysAdminRepository)
class ShowPackageHistorySysAdminRepositoryImpl
    implements ShowPackageHistorySysAdminRepository {
  const ShowPackageHistorySysAdminRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowPackageHistorySysAdminRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, PackageHistoryInSysAdminResponse>> call({
    required ShowPackageHistorySysAdminEntity parameters,
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