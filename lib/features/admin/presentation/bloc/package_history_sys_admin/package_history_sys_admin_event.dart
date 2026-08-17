import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';
import 'package:equatable/equatable.dart';

sealed class PackageHistorySysAdminEvent extends Equatable {
  const PackageHistorySysAdminEvent();

  @override
  List<Object?> get props => [];
}

class GetPackageHistorySysAdminRequested
    extends PackageHistorySysAdminEvent {
  const GetPackageHistorySysAdminRequested({
    required this.parameters,
  });

  final ShowPackageHistorySysAdminEntity parameters;

  @override
  List<Object?> get props => [
        parameters,
      ];
}