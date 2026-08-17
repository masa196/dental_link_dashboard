import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/package_history_sys_admin/package_history_sys_admin_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class ShowPackageHistorySysAdminUsecase
    extends BaseUseCase<PackageHistoryInSysAdminResponse, ShowPackageHistorySysAdminEntity> {
  ShowPackageHistorySysAdminUsecase(this.repository);

  final ShowPackageHistorySysAdminRepository repository;

  @override
  Future<Either<AppFailure, PackageHistoryInSysAdminResponse>> call(
    ShowPackageHistorySysAdminEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
