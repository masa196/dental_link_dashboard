import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/delete_department/delete_department_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/delete_department/delete_department_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/delete_department/delete_department_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class DeleteDepartmentDialog extends StatefulWidget {
  const DeleteDepartmentDialog({
    super.key,
    required this.departmentId,
    required this.departmentName,
  });

  final int departmentId;
  final String departmentName;

  @override
  State<DeleteDepartmentDialog> createState() => _DeleteDepartmentDialogState();
}

class _DeleteDepartmentDialogState extends State<DeleteDepartmentDialog> {
  late final DeleteDepartmentBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = locator<DeleteDepartmentBloc>();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;

    return BlocProvider.value(
      value: _bloc,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        child: Container(
          width: 460,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: BlocListener<DeleteDepartmentBloc, DeleteDepartmentBlocState>(
            listener: (context, state) {
              if (state.status == DeleteDepartmentStatus.success) {
                Navigator.of(context).pop(
                  state.responseModel?.message ??
                      (isArabic
                          ? 'تم حذف القسم بنجاح'
                          : 'Department deleted successfully'),
                );
                return;
              }

              if (state.status == DeleteDepartmentStatus.failure) {
                DepartmentSnackbarHelper.showFailure(
                  context,
                  title: isArabic
                      ? 'تعذر حذف القسم'
                      : 'Unable to delete department',
                  message:
                      state.failure?.message ??
                      (isArabic
                          ? 'حدث خطأ أثناء حذف القسم'
                          : 'An error occurred while deleting the department'),
                  failure: state.failure,
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.delete_outline_rounded,
                  size: 42,
                  color: scheme.error,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  isArabic ? 'حذف القسم' : 'Delete department',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppTypography.fs18,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  isArabic
                      ? 'هل تريد حذف قسم "${widget.departmentName}"؟'
                      : 'Do you want to delete "${widget.departmentName}"?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppTypography.fs14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                          BlocBuilder<
                            DeleteDepartmentBloc,
                            DeleteDepartmentBlocState
                          >(
                            builder: (context, state) {
                              final isLoading =
                                  state.status ==
                                  DeleteDepartmentStatus.loading;
                              return FilledButton.tonal(
                                onPressed: isLoading ? null : _submit,
                                style: FilledButton.styleFrom(
                                  backgroundColor: scheme.error.withValues(
                                    alpha: 0.12,
                                  ),
                                  foregroundColor: scheme.error,
                                ),
                                child: Text(isArabic ? 'حذف' : 'Delete'),
                              );
                            },
                          ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(isArabic ? 'إلغاء' : 'Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    _bloc.add(DeleteDepartmentSubmitted(departmentId: widget.departmentId));
  }
}
