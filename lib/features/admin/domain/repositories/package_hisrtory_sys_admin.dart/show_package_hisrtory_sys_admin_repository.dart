import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/package_history_sys_admin/package_history_sys_admin_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';

abstract interface class ShowPackageHistorySysAdminRepository {
  Future<Either<AppFailure, PackageHistoryInSysAdminResponse>> call({
    required ShowPackageHistorySysAdminEntity parameters,
  });
}


