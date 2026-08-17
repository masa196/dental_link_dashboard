import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/package_history_sys_admin/package_history_sys_admin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageHistorySysAdminPage extends StatelessWidget {
  const PackageHistorySysAdminPage({
    super.key,
    required this.labId,
    required this.labName,
  });

  final int labId;
  final String labName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => locator<PackageHistorySysAdminBloc>()
        ..add(
          GetPackageHistorySysAdminRequested(
            parameters: ShowPackageHistorySysAdminEntity(
              labId: labId,
            ),
          ),
        ),
      child: PackageHistorySysAdminView(
        labId: labId,
        labName: labName,
      ),
    );
  }
}