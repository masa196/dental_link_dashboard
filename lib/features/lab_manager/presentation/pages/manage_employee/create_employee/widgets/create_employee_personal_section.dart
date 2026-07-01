import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart'
    as departments_model;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart'; // ✅ إضافة الـ Bloc
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart'; // ✅ إضافة الـ Bloc
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/employee_date_picker.dart';

import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';

import 'create_employee_section_card.dart';

class CreateEmployeePersonalSection extends StatefulWidget {
  const CreateEmployeePersonalSection({
    super.key,
    required this.rolesState,
    required this.departmentsState,
  });

  final RolesBlocState rolesState;
  final DepartmentsWithEmployeeState departmentsState;

  @override
  State<CreateEmployeePersonalSection> createState() =>
      _CreateEmployeePersonalSectionState();
}

class _CreateEmployeePersonalSectionState
    extends State<CreateEmployeePersonalSection> {
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

    // ✅ التعديل: نعتمد على استماع حقيقي للـ Blocs لمنع تدمير شجرة الـ Dropdown والـ Chips
    return BlocBuilder<
      DepartmentsWithEmployeeBloc,
      DepartmentsWithEmployeeState
    >(
      builder: (context, currentDepState) {
        final departmentsLoading =
            currentDepState.isInitialLoading || !currentDepState.hasData;

        return BlocBuilder<CreateEmployeeFormCubit, CreateEmployeeFormState>(
          builder: (context, formState) {
            // keep controllers in sync with cubit state
            if (_birthController.text != formState.birthdate) {
              _birthController.text = formState.birthdate;
            }
            if (_joinedController.text != formState.joinedAt) {
              _joinedController.text = formState.joinedAt;
            }

            return CreateEmployeeSectionCard(
              title: isArabic ? 'البيانات الشخصية' : 'Personal information',
              icon: Icons.badge_outlined,
              headerAction: _buildRoleDropdown(context, formState),
              children: [
                if (departmentsLoading) ...[
                  _SectionStatusBanner(
                    message: isArabic
                        ? 'جارٍ تحميل الأقسام...'
                        : 'Loading departments...',
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                _buildTopGrid(context, currentDepState, formState),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTopGrid(
    BuildContext context,
    DepartmentsWithEmployeeState currentDepState,
    CreateEmployeeFormState formState,
  ) {
    final isArabic = context.isArabic;
    final departments =
        currentDepState.departments; // استخدام الـ state المحدث والآمن

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
            setter: context.read<CreateEmployeeFormCubit>().updateBirthdate,
            clearError: () =>
                context.read<CreateEmployeeFormCubit>().clearBirthdateError(),
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
            setter: context.read<CreateEmployeeFormCubit>().updateJoinedAt,
            clearError: () =>
                context.read<CreateEmployeeFormCubit>().clearJoinedAtError(),
          ),
        );

        final children = [
          AppTextField(
            initialValue: formState.name,
            labelText: isArabic ? 'اسم الموظف' : 'Employee name',
            hint: isArabic ? 'أدخل اسم الموظف' : 'Enter employee name',
            icon: Icons.person_outline_rounded,
            errorText: formState.nameError,
            onTap: () =>
                context.read<CreateEmployeeFormCubit>().clearNameError(),
            onChanged: context.read<CreateEmployeeFormCubit>().updateName,
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

    return BlocBuilder<CreateEmployeeFormCubit, CreateEmployeeFormState>(
      builder: (context, state) {
        final selectedDepartmentIds = state.departmentIds;
        final selectedDepartments = departments
            .where(
              (department) =>
                  department.id != null &&
                  selectedDepartmentIds.contains(department.id),
            )
            .toList();

        return InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: departments.isEmpty
              ? null
              : () => _showDepartmentMultiSelectSheet(context, departments),
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
                            isArabic
                                ? 'اختر قسمًا واحدًا أو أكثر'
                                : 'Select one or more departments',
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
                      children: selectedDepartments
                          .map(
                            (department) => _SelectedDepartmentChip(
                              label:
                                  department.name ??
                                  (isArabic
                                      ? 'قسم بدون اسم'
                                      : 'Untitled department'),
                              onRemove: department.id == null
                                  ? null
                                  : () => context
                                        .read<CreateEmployeeFormCubit>()
                                        .toggleDepartment(department.id!),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDepartmentMultiSelectSheet(
    BuildContext context,
    List<departments_model.DepartmentItem> departments,
  ) async {
    final isArabic = context.isArabic;
    final isWebLike = kIsWeb || MediaQuery.of(context).size.width >= 900;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<CreateEmployeeFormCubit>(),
          child: Dialog(
            insetPadding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 880,
                maxHeight: MediaQuery.sizeOf(dialogContext).height * 0.82,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: BlocBuilder<CreateEmployeeFormCubit, CreateEmployeeFormState>(
                  builder: (context, state) {
                    final selectedCount = state.departmentIds.length;
                    final availableDepartments = departments
                        .where((department) => department.id != null)
                        .toList(growable: false);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isArabic
                                        ? 'اختر الأقسام'
                                        : 'Select departments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    isArabic
                                        ? 'يمكنك اختيار أكثر من قسم لموظف واحد'
                                        : 'You can assign the employee to multiple departments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(alpha: 0.68),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            _SelectionCountBadge(
                              count: selectedCount,
                              isArabic: isArabic,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Scrollbar(
                            thumbVisibility: isWebLike,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: isWebLike ? 280 : 420,
                                    mainAxisExtent: 64,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                              itemCount: availableDepartments.length,
                              itemBuilder: (context, index) {
                                final department = availableDepartments[index];
                                final departmentId = department.id!;
                                final selected = state.departmentIds.contains(
                                  departmentId,
                                );

                                return _DepartmentChoiceTile(
                                  label:
                                      department.name ??
                                      (isArabic
                                          ? 'قسم بدون اسم'
                                          : 'Untitled department'),
                                  selected: selected,
                                  onTap: () => context
                                      .read<CreateEmployeeFormCubit>()
                                      .toggleDepartment(departmentId),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              child: Text(isArabic ? 'تم' : 'Done'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ تعديل جوهري هنا: نستمع للـ RolesBloc مباشرة لحماية الـ Dropdown من الانهيار والتحميل
  Widget _buildRoleDropdown(
    BuildContext context,
    CreateEmployeeFormState formState,
  ) {
    final isArabic = context.isArabic;

    return BlocBuilder<RolesBloc, RolesBlocState>(
      builder: (context, currentRolesState) {
        final isLoadingRoles =
            currentRolesState.isLoading && currentRolesState.roles.isEmpty;

        // تحقق آمن تماماً يمنع الـ Crash أو الـ Desync المؤدي لإعادة طلب البيانات
        final selectedRoleExists = currentRolesState.roles.any(
          (role) => role.id == formState.roleId,
        );

        return DropdownButtonFormField<int>(
          initialValue: selectedRoleExists ? formState.roleId : null,
          isExpanded: true,
          onTap: () => context.read<CreateEmployeeFormCubit>().clearRoleError(),
          decoration: _inputDecoration(
            context,
            label: isArabic ? 'الدور' : 'Role',
            hint: isLoadingRoles
                ? (isArabic ? 'جارٍ تحميل الأدوار' : 'Loading roles')
                : (isArabic ? 'اختر الدور' : 'Select role'),
            icon: Icons.badge_outlined,
            errorText: formState.roleError,
            suffixIcon: isLoadingRoles
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: context.scheme.primary,
                      ),
                    ),
                  )
                : null,
          ),
          items: currentRolesState.roles
              .map(
                (role) => DropdownMenuItem<int>(
                  value: role.id,
                  child: Text(
                    role.name ?? (isArabic ? 'دور بدون اسم' : 'Untitled role'),
                  ),
                ),
              )
              .toList(),
          onChanged: currentRolesState.roles.isEmpty
              ? null
              : (value) =>
                    context.read<CreateEmployeeFormCubit>().setRole(value),
        );
      },
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
    String? errorText,
  }) {
    final scheme = context.scheme;

    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      errorText: errorText,
      filled: true,
      fillColor:
          Theme.of(context).inputDecorationTheme.fillColor ?? scheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(color: scheme.primary, width: 1.4),
      ),
    );
  }
}

// ... بقية الـ Widgets المساعدة للأشكال (_SelectedDepartmentChip, _SelectionCountBadge, _DepartmentChoiceTile, _SectionStatusBanner) تظل كما هي تماماً بدون تغيير لتوفير المساحة ...

class _SelectedDepartmentChip extends StatelessWidget {
  const _SelectedDepartmentChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.16)),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 12, end: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            if (onRemove != null)
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 18),
                splashRadius: 18,
              ),
          ],
        ),
      ),
    );
  }
}

class _SelectionCountBadge extends StatelessWidget {
  const _SelectionCountBadge({required this.count, required this.isArabic});

  final int count;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isArabic ? 'المحدد: $count' : 'Selected: $count',
        style: TextStyle(fontWeight: FontWeight.w800, color: scheme.primary),
      ),
    );
  }
}

class _DepartmentChoiceTile extends StatelessWidget {
  const _DepartmentChoiceTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary.withValues(alpha: 0.08)
                : scheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? scheme.primary.withValues(alpha: 0.35)
                  : scheme.outlineVariant.withValues(alpha: 0.35),
              width: selected ? 1.4 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: selected ? 0.08 : 0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: selected ? scheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: selected
                        ? scheme.primary
                        : scheme.outlineVariant.withValues(alpha: 0.8),
                  ),
                ),
                child: selected
                    ? Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: scheme.onPrimary,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionStatusBanner extends StatelessWidget {
  const _SectionStatusBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.08)),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: scheme.onSurface.withValues(alpha: 0.72),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Date masking handled by calendar picker; manual typing disabled.
