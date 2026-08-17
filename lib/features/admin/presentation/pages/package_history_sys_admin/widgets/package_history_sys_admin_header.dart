import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/package_history_sys_admin/widgets/assign_package_dialog.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageHistorySysAdminHeader extends StatelessWidget {
  const PackageHistorySysAdminHeader({
    super.key,
    required this.labId,
    required this.labName,
  });

  final int labId;
  final String labName;

  @override
  Widget build(BuildContext context) {
    return DashboardHeader(
      showMenuButton: !Responsive.isDesktop(context),
      title: 'سجل باقات $labName',
      showSearchBar: false,
      showNotification: false,
      trailing: FilledButton.icon(
        onPressed: () async {
          final assigned = await showDialog<bool>(
            context: context,
            barrierDismissible: true,
            builder: (_) => AssignPackageDialog(
              labId: labId,
            ),
          );

          if (assigned == true && context.mounted) {
            context.read<PackageHistorySysAdminBloc>().add(
                  GetPackageHistorySysAdminRequested(
                    parameters: ShowPackageHistorySysAdminEntity(
                      labId: labId,
                      page: 1,
                    ),
                  ),
                );
          }
        },
        icon: const Icon(
          Icons.add,
          size: 18,
        ),
        label: const Text('إسناد باقة'),
      ),
    );
  }
}