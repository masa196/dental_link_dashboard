import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart' as departments_model;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/employee_date_picker.dart';
import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';
import 'edit_employee_section_card.dart';

class EditEmployeePersonalSection extends StatefulWidget {
  const EditEmployeePersonalSection({
    super.key,
    required this.rolesState,
    required this.departmentsState,
  });

  final RolesBlocState rolesState;
  final DepartmentsWithEmployeeState departmentsState;

  @override
  State<EditEmployeePersonalSection> createState() => _EditEmployeePersonalSectionState();
}

class _EditEmployeePersonalSectionState extends State<EditEmployeePersonalSection> {
  late final TextEditingController _birthController;
  late final TextEditingController _joinedController;

  @override
  void initState() {
    super.initState();
    _birthController = TextEditingController();
    _joinedController = TextEditingController();
  }

  @override
  void dispose() {
    _birthController.dispose();
    _joinedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final departmentsLoading = widget.departmentsState.isInitialLoading || !widget.departmentsState.hasData;

    return BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
      builder: (context, formState) {
        if (_birthController.text != formState.birthdate) {
          _birthController.text = formState.birthdate;
        }
        if (_joinedController.text != formState.joinedAt) {
          _joinedController.text = formState.joinedAt;
        }
        return EditEmployeeSectionCard(
          title: isArabic ? 'البيانات الشخصية' : 'Personal information',
          icon: Icons.badge_outlined,
          headerAction: _buildRoleDropdown(
            context,
            widget.rolesState,
            formState,
          ),
          children: [
            if (departmentsLoading) ...[
              _SectionStatusBanner(
                message: isArabic ? 'جارٍ تحميل الأقسام...' : 'Loading departments...',
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            _buildTopGrid(context, formState),
          ],
        );
      },
    );
  }

  Widget _buildTopGrid(BuildContext context, UpdateEmployeeFormState formState) {
    final isArabic = context.isArabic;
    final departments = widget.departmentsState.departments;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 680;

        Future<void> pickDateAndSet({
          required BuildContext ctx,
          required TextEditingController controller,
          required void Function(String) setter,
          required VoidCallback clearError,
        }) async {
          clearError();
          final first = DateTime(1950, 1, 1);
          final lastDynamic = DateTime(DateTime.now().year, 12, 31);

          final picked = await EmployeeDatePicker.pickMaskedDate(
            ctx,
            initialDate: DateTime.now(),
            firstDate: first,
            lastDate: lastDynamic,
            closeLabel: isArabic ? 'إغلاق' : 'Close',
          );
          if (picked == null) return;
          controller.text = picked;
          setter(picked);
        }

        final birthField = AppTextField(
          controller: _birthController,
          labelText: isArabic ? 'تاريخ الميلاد' : 'Birthdate',
          hint: 'DD / MM / YYYY',
          icon: Icons.cake_outlined,
          errorText: formState.birthdateError,
          readOnly: true,
          onTap: () => pickDateAndSet(
            ctx: context,
            controller: _birthController,
            setter: context.read<UpdateEmployeeFormCubit>().updateBirthdate,
            clearError: () => context.read<UpdateEmployeeFormCubit>().clearBirthdateError(),
          ),
        );

        final joinedField = AppTextField(
          controller: _joinedController,
          labelText: isArabic ? 'تاريخ الانضمام' : 'Joined date',
          hint: 'DD / MM / YYYY',
          icon: Icons.event_available_outlined,
          errorText: formState.joinedAtError,
          readOnly: true,
          onTap: () => pickDateAndSet(
            ctx: context,
            controller: _joinedController,
            setter: context.read<UpdateEmployeeFormCubit>().updateJoinedAt,
            clearError: () => context.read<UpdateEmployeeFormCubit>().clearJoinedAtError(),
          ),
        );

        final children = [
          AppTextField(
            initialValue: formState.name,
            labelText: isArabic ? 'اسم الموظف' : 'Employee name',
            hint: isArabic ? 'أدخل اسم الموظف' : 'Enter employee name',
            icon: Icons.person_outline_rounded,
            errorText: formState.nameError,
            onTap: () => context.read<UpdateEmployeeFormCubit>().clearNameError(),
            onChanged: context.read<UpdateEmployeeFormCubit>().updateName,
          ),
          birthField,
          _buildDepartmentsMultiSelectField(context, departments),
          joinedField,
        ];

        if (isCompact) {
          return Column(
            children: [
              for (final child in children) ...[
                child,
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        }

        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: children
              .map(
                (child) => SizedBox(
                  width: (constraints.maxWidth - AppSpacing.md) / 2,
                  child: child,
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildDepartmentsMultiSelectField(
    BuildContext context,
    List<departments_model.DepartmentItem> departments,
  ) {
    final isArabic = context.isArabic;
    final scheme = context.scheme;

    return BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
      builder: (context, state) {
        final selectedDepartmentIds = state.departmentIds;
        
        final selectedDepartments = departments.where((dept) {
          if (dept.id == null) return false;
          final int deptId = dept.id is int ? dept.id as int : (int.tryParse(dept.id.toString()) ?? 0);
          return selectedDepartmentIds.contains(deptId);
        }).toList();

        return InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: departments.isEmpty ? null : () => _showDepartmentMultiSelectSheet(context, departments),
          child: InputDecorator(
            decoration: _inputDecoration(
              context,
              label: isArabic ? 'الأقسام' : 'Departments',
              hint: isArabic ? 'اختر الأقسام' : 'Select departments',
              icon: Icons.apartment_outlined,
              errorText: state.departmentError,
              suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: selectedDepartments.isEmpty
                  ? Row(
                      key: const ValueKey('departments-empty'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            isArabic ? 'اختر قسمًا واحدًا أو أكثر' : 'Select one or more departments',
                            style: TextStyle(
                              color: scheme.onSurface.withValues(alpha: 0.58),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Wrap(
                      key: const ValueKey('departments-selected'),
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedDepartments.map((dept) {
                        final int deptId = dept.id is int ? dept.id as int : (int.tryParse(dept.id.toString()) ?? 0);
                        return _SelectedDepartmentChip(
                          label: dept.name ?? (isArabic ? 'قسم بدون اسم' : 'Untitled department'),
                          onRemove: () {
                            context.read<UpdateEmployeeFormCubit>().toggleDepartment(deptId);
                          },
                        );
                      }).toList(),
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showDepartmentMultiSelectSheet(
    BuildContext context,
    List<departments_model.DepartmentItem> departments,
  ) {
    final isArabic = context.isArabic;
    final scheme = context.scheme;
    final cubit = context.read<UpdateEmployeeFormCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
            builder: (context, state) {
              return Directionality(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isArabic ? 'اختر الأقسام المختصة' : 'Select Departments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: departments.length,
                          itemBuilder: (context, index) {
                            final dept = departments[index];
                            if (dept.id == null) return const SizedBox.shrink();

                            final int deptId = dept.id is int ? dept.id as int : (int.tryParse(dept.id.toString()) ?? 0);
                            final isSelected = state.departmentIds.contains(deptId);

                            return CheckboxListTile(
                              title: Text(dept.name ?? ''),
                              value: isSelected,
                              activeColor: scheme.primary,
                              onChanged: (_) {
                                cubit.clearDepartmentError();
                                cubit.toggleDepartment(deptId);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: Text(isArabic ? 'موافق' : 'Done'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRoleDropdown(
    BuildContext context,
    RolesBlocState rolesState,
    UpdateEmployeeFormState formState,
  ) {
    final isArabic = context.isArabic;

    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<int>(
        initialValue: formState.roleId,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          labelText: isArabic ? 'الدور الوظيفي' : 'Role',
          errorText: formState.roleError,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        items: rolesState.roles.map((role) {
          return DropdownMenuItem<int>(
            value: role.id,
            child: Text(role.name ?? '', style: const TextStyle(fontSize: 13)),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) {
            context.read<UpdateEmployeeFormCubit>().clearRoleError();
            context.read<UpdateEmployeeFormCubit>().updateRoleId(val);
          }
        },
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    String? errorText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      suffixIcon: suffixIcon,
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }
}

class _SelectedDepartmentChip extends StatelessWidget {
  const _SelectedDepartmentChip({required this.label, this.onRemove});
  final String label;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: scheme.onPrimaryContainer,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (onRemove != null) ...[
            const SizedBox(width: 5),
            InkWell(
              onTap: onRemove,
              child: Icon(Icons.close_rounded, size: 14, color: scheme.primary),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionStatusBanner extends StatelessWidget {
  const _SectionStatusBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.amber.shade900, fontSize: 12),
      ),
    );
  }
}