import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';

class MaterialsHeader extends StatelessWidget {
  const MaterialsHeader({
    super.key,
    required this.title,
    this.onAdd,
    this.onSearch,
    this.showAddButton = true,
    this.onNotificationTap,
    this.addButtonLabel = "إضافة مادة",
  });

  final String title;
  final VoidCallback? onAdd;
  final bool showAddButton;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onNotificationTap;
  final String addButtonLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: DashboardHeader(
        showMenuButton: !Responsive.isDesktop(context),
        title: title,
        onSearch: onSearch,
        onNotificationTap: onNotificationTap,

        trailing: showAddButton
            ? FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 18),
                label: Text(addButtonLabel),
              )
            : null,
      ),
    );
  }
}
