import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';
import 'package:flutter/material.dart';

class DepartmentDropdown extends StatelessWidget {
  const DepartmentDropdown({
    super.key,
    required this.departmentId,
    required this.departmentName,
    required this.departments,
    required this.enabled,
    required this.onChanged,
  });

  final int departmentId;

  final String departmentName;

  final List<DepartmentItem> departments;

  final bool enabled;

  final ValueChanged<DepartmentItem> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    if (!enabled) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
          border: Border.all(
            color: scheme.outlineVariant,
          ),
        ),
        child: Text(
          departmentName,
          style: const TextStyle(
            fontSize: AppTypography.fs10,
          ),
        ),
      );
    }

    final selectedDepartment = departments
        .where(
          (department) =>
              department.id == departmentId,
        )
        .firstOrNull;

    return DropdownButtonFormField<DepartmentItem>(
      value: selectedDepartment,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
        ),
      ),
      items: departments.map(
        (department) {
          return DropdownMenuItem<DepartmentItem>(
            value: department,
            child: Text(
              department.name ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: (department) {
        if (department == null) return;

        onChanged(department);
      },
    );
  }
}