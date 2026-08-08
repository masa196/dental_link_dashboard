import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_stages/order_stages_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_order_stages/order_stages_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/get_order_stages/get_order_stages_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/get_order_stages/get_order_stages_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/get_order_stages/get_order_stages_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/update_order_stages/update_order_stages_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/update_order_stages/update_order_stages_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/update_order_stages/update_order_stages_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/manage_order_stages/editable_order_stage.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/manage_order_stages/order_stage_row.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStagesDialog extends StatefulWidget {
  const OrderStagesDialog({super.key, required this.departments});

  final List<DepartmentItem> departments;

  @override
  State<OrderStagesDialog> createState() => _OrderStagesDialogState();
}

class _OrderStagesDialogState extends State<OrderStagesDialog> {
  bool isEditing = false;

  bool initialized = false;

  bool isSaving = false;

  List<EditableOrderStage> editableStages = [];

  List<EditableOrderStage> originalStages = [];

  void _initializeStages(List<OrderStageDepartment> stages) {
    editableStages = stages.map((stage) {
      return EditableOrderStage(
        departmentId: stage.id ?? 0,

        departmentName: stage.name ?? '',

        hours: stage.timeAllowedHours ?? 1,
      );
    }).toList();

    originalStages = editableStages.map((stage) => stage.copy()).toList();

    initialized = true;
  }

  void _startEditing() {
    originalStages = editableStages.map((stage) => stage.copy()).toList();

    setState(() {
      isEditing = true;
    });
  }

  void _cancelEditing() {
    editableStages = originalStages.map((stage) => stage.copy()).toList();

    setState(() {
      isEditing = false;
    });
  }

  void _onDepartmentChanged(int index, DepartmentItem department) {
    setState(() {
      editableStages[index]
        ..departmentId = department.id ?? 0
        ..departmentName = department.name ?? '';
    });
  }

  void _onHoursChanged(int index, int hours) {
    setState(() {
      editableStages[index].hours = hours;
    });
  }

  void _addStage() {
    if (editableStages.length >= 6) {
      return;
    }

    setState(() {
      editableStages.add(
        EditableOrderStage(departmentId: 0, departmentName: '', hours: 1),
      );
    });
  }

  void _removeStage(int index) {
    if (editableStages.length <= 4) {
      return;
    }

    setState(() {
      editableStages.removeAt(index);
    });
  }

  void _save(BuildContext context) {
    final isInvalid = editableStages.any(
      (stage) => stage.departmentId == 0 || stage.hours <= 0,
    );

    if (isInvalid) {
      AppSnackbarHelper.showFailure(
        context,

        title: context.isArabic ? 'بيانات غير مكتملة' : 'Incomplete data',

        message: context.isArabic
            ? 'يرجى اختيار القسم وتحديد المدة لكل مرحلة'
            : 'Please select department and duration for every stage',

        failure: null,
      );

      return;
    }

    final departmentIds = editableStages
        .map((stage) => stage.departmentId)
        .toList();

    final hours = editableStages.map((stage) => stage.hours).toList();

    context.read<UpdateOrderStagesBloc>().add(
      UpdateOrderStagesRequested(
        parameters: OrderStagesEntity(
          departmentIds: departmentIds,

          departmentTimeAllowedHours: hours,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    final isArabic = context.isArabic;

    return BlocConsumer<UpdateOrderStagesBloc, UpdateOrderStagesState>(
      listener: (context, updateState) {
        if (updateState.isLoading) {
          setState(() {
            isSaving = true;
          });
        }

        if (updateState.isSuccess) {
          setState(() {
            isSaving = false;

            isEditing = false;
          });

          AppSnackbarHelper.showSuccess(
            context,

            title: isArabic
                ? 'تم تحديث مراحل الطلبية'
                : 'Order workflow updated',

            message: isArabic
                ? 'تم حفظ إعدادات مراحل الطلبية بنجاح'
                : 'Order workflow settings saved successfully',
          );

          context.read<GetOrderStagesBloc>().add(
            const GetOrderStagesRequested(),
          );

          Navigator.pop(context);
        }

        if (updateState.failure != null) {
          setState(() {
            isSaving = false;
          });

          AppSnackbarHelper.showFailure(
            context,

            title: isArabic
                ? 'فشل تحديث مراحل الطلبية'
                : 'Failed to update workflow',

            message: updateState.failure!.message,

            failure: updateState.failure,
          );
        }
      },

      builder: (context, updateState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),

          contentPadding: const EdgeInsets.all(AppSpacing.xl),

          content: SizedBox(
            width: 650,

            child: BlocConsumer<GetOrderStagesBloc, GetOrderStagesState>(
              listener: (context, state) {
                final stages = state.response?.data?.departments ?? [];

                if (!initialized && stages.isNotEmpty) {
                  _initializeStages(stages);

                  setState(() {});
                }
              },

              builder: (context, state) {
                if (state.isLoading) {
                  return const SizedBox(
                    height: 350,

                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state.failure != null) {
                  return SizedBox(
                    height: 350,

                    child: Center(
                      child: Text(
                        state.failure!.message,

                        style: TextStyle(
                          color: scheme.error,

                          fontSize: AppTypography.fs16,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      isArabic ? 'إدارة أقسام الطلبية' : 'Order Workflow',

                      style: const TextStyle(
                        fontSize: AppTypography.fs22,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      isEditing
                          ? (isArabic
                                ? 'يمكنك تعديل القسم والمدة لكل مرحلة.'
                                : 'You can edit department and duration for each stage.')
                          : (isArabic
                                ? 'الأقسام التالية تمثل مسار الطلبية.'
                                : 'The following departments define the workflow.'),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,

                        itemCount: editableStages.length,

                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.md),

                        itemBuilder: (_, index) {
                          final stage = editableStages[index];

                          return OrderStageRow(
                            stage: stage,
                            departments: widget.departments,
                            enabled: isEditing && !isSaving,

                            showDeleteButton:
                                isEditing && editableStages.length > 4,

                            onDelete: () {
                              _removeStage(index);
                            },

                            onDepartmentChanged: (department) {
                              _onDepartmentChanged(index, department);
                            },

                            onHoursChanged: (hours) {
                              _onHoursChanged(index, hours);
                            },
                          );
                        },
                      ),
                    ),

                    if (isEditing && editableStages.length < 6)
                      const SizedBox(height: AppSpacing.lg),

                    if (isEditing && editableStages.length < 6)
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: _addStage,

                          icon: const Icon(Icons.add),

                          label: Text(isArabic ? 'إضافة مرحلة' : 'Add Stage'),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),

          actions: [
            if (!isEditing)
              TextButton(
                onPressed: () => Navigator.pop(context),

                child: Text(isArabic ? 'إغلاق' : 'Close'),
              ),

            if (!isEditing)
              ElevatedButton(
                onPressed: _startEditing,

                child: Text(isArabic ? 'تعديل' : 'Edit'),
              ),

            if (isEditing)
              TextButton(
                onPressed: isSaving ? null : _cancelEditing,

                child: Text(isArabic ? 'إلغاء' : 'Cancel'),
              ),

            if (isEditing)
              ElevatedButton(
                onPressed: isSaving ? null : () => _save(context),

                child: isSaving
                    ? const SizedBox(
                        width: 18,

                        height: 18,

                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isArabic ? 'حفظ' : 'Save'),
              ),
          ],
        );
      },
    );
  }
}
