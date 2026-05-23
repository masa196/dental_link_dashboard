import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/update_department/update_department_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/update_department/update_department_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/update_department/update_department_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class EditDepartmentDialog extends StatefulWidget {
  const EditDepartmentDialog({
    super.key,
    required this.departmentId,
    required this.initialName,
  });

  final int departmentId;
  final String initialName;

  @override
  State<EditDepartmentDialog> createState() => _EditDepartmentDialogState();
}

class _EditDepartmentDialogState extends State<EditDepartmentDialog> {
  late final UpdateDepartmentBloc _bloc;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _bloc = locator<UpdateDepartmentBloc>();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
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
          width: 520,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: BlocListener<UpdateDepartmentBloc, UpdateDepartmentBlocState>(
            listener: (context, state) {
              if (state.status == UpdateDepartmentStatus.success) {
                Navigator.of(context).pop(
                  state.responseModel?.message ??
                      (isArabic
                          ? 'تم تعديل القسم بنجاح'
                          : 'Department updated successfully'),
                );
                return;
              }

              if (state.status == UpdateDepartmentStatus.failure) {
                DepartmentSnackbarHelper.showFailure(
                  context,
                  title: isArabic
                      ? 'تعذر تعديل القسم'
                      : 'Unable to update department',
                  message:
                      state.failure?.message ??
                      (isArabic
                          ? 'حدث خطأ أثناء تعديل القسم'
                          : 'An error occurred while updating the department'),
                  failure: state.failure,
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    isArabic ? 'تعديل اسم القسم' : 'Edit department name',
                    style: TextStyle(
                      fontSize: AppTypography.fs18,
                      fontWeight: FontWeight.w800,
                      color: scheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: isArabic
                        ? 'أدخل اسم القسم'
                        : 'Enter department name',
                    filled: true,
                    fillColor:
                        Theme.of(context).inputDecorationTheme.fillColor ??
                        scheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                          BlocBuilder<
                            UpdateDepartmentBloc,
                            UpdateDepartmentBlocState
                          >(
                            builder: (context, state) {
                              final isLoading =
                                  state.status ==
                                  UpdateDepartmentStatus.loading;
                              return ElevatedButton(
                                onPressed: isLoading ? null : _submit,
                                child: Text(
                                  isArabic ? 'حفظ التغييرات' : 'Save changes',
                                ),
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
    final isArabic = context.isArabic;
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      DepartmentSnackbarHelper.showFailure(
        context,
        title: isArabic ? 'بيانات ناقصة' : 'Incomplete data',
        message: isArabic ? 'أدخل اسم القسم' : 'Enter department name',
      );
      return;
    }

    _bloc.add(
      UpdateDepartmentSubmitted(
        departmentId: widget.departmentId,
        params: DepartmentNameEntity(name: name),
      ),
    );
  }
}
