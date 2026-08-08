import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';

import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/manage_order_stages/department_dropdown.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/manage_order_stages/editable_order_stage.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/manage_order_stages/hours_dropdown.dart';
import 'package:flutter/material.dart';

class OrderStageRow extends StatelessWidget {
  const OrderStageRow({
    super.key,
    required this.stage,
    required this.departments,
    required this.enabled,
    required this.onDepartmentChanged,
    required this.onHoursChanged,
    this.showDeleteButton = false,
    this.onDelete,
  });

  final EditableOrderStage stage;

  final List<DepartmentItem> departments;

  /// هل الصف في وضع التعديل؟
  final bool enabled;

  final ValueChanged<DepartmentItem> onDepartmentChanged;

  final ValueChanged<int> onHoursChanged;


  /// إظهار زر حذف المرحلة
  final bool showDeleteButton;

  /// تنفيذ حذف المرحلة
  final VoidCallback? onDelete;


  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;


    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),

      decoration: BoxDecoration(
        color: scheme.surface,

        borderRadius: BorderRadius.circular(
          AppRadius.lg,
        ),

        border: Border.all(
          color: scheme.outlineVariant.withValues(
            alpha: .25,
          ),
        ),
      ),


      child: Row(
        children: [

          Expanded(
            flex: 3,

            child: DepartmentDropdown(
              departmentId:
                  stage.departmentId,

              departmentName:
                  stage.departmentName,

              departments:
                  departments,

              enabled:
                  enabled,

              onChanged:
                  onDepartmentChanged,
            ),
          ),



          const SizedBox(
            width: AppSpacing.lg,
          ),



          Expanded(
            flex: 2,

            child: HoursDropdown(
              hours:
                  stage.hours,

              enabled:
                  enabled,

              onChanged:
                  onHoursChanged,
            ),
          ),



          if (showDeleteButton) ...[

            const SizedBox(
              width: AppSpacing.sm,
            ),


            IconButton(
              tooltip:
                  context.isArabic
                      ? 'حذف المرحلة'
                      : 'Delete stage',

              onPressed:
                  enabled
                      ? onDelete
                      : null,


              icon: Icon(
                Icons.delete_outline_rounded,

                color:
                    scheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}