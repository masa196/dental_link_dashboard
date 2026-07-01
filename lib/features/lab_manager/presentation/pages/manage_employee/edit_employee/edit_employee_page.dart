import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/edit_employee/widgets/edit_employee_contact_fields.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/edit_employee/widgets/edit_employee_security_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/navigation/app_breadcrumbs.dart';
import 'package:dental_link_dashboard/core/navigation/app_route_paths.dart';
import 'package:dental_link_dashboard/core/utils/app_validators.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/edit_employee/update_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/edit_employee/update_employee_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/edit_employee/update_employee_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

import 'widgets/edit_employee_personal_section.dart';
import 'widgets/edit_employee_profile_card.dart';
import 'widgets/edit_employee_top_bar.dart';

class EditEmployeePage extends StatelessWidget {
  const EditEmployeePage({
    super.key,
    this.employee, // 🛡️ تم تعديله ليصبح اختيارياً لحل مشكلة الـ Type Assignment في الـ Router
    this.departmentName,
  });

  final EmployeeEntity? employee;
  final String? departmentName;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    // 🛑 صمام الأمان: في حال وصول المستخدم بدون تمرير كائن الموظف (مثل عمل Refresh)
    if (employee == null) {
      return Scaffold(
        appBar: AppBar(title: Text(isArabic ? 'تعديل موظف' : 'Edit Employee')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              isArabic
                  ? 'عذراً، لم يتم العثور على بيانات الموظف (يرجى الانتقال من شاشة إدارة الموظفين).'
                  : 'Sorry, employee data not found (Please navigate from the employees management page).',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    // 🟢 حماية وحقن الكاش الآمن قبل بناء الواجهة بدون الحاجة لـ Stateful
    final departmentsBloc = context.read<DepartmentsWithEmployeeBloc>();
    final rolesBloc = context.read<RolesBloc>();

    if (departmentsBloc.state.departments.isEmpty &&
        !departmentsBloc.state.isInitialLoading) {
      departmentsBloc.add(const DepartmentsWithEmployeeFetchRequested());
    }
    if (rolesBloc.state.roles.isEmpty && !rolesBloc.state.isLoading) {
      rolesBloc.add(const RolesFetchRequested());
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UpdateEmployeeFormCubit(employee: employee!),
        ),
        BlocProvider(create: (_) => locator<UpdateEmployeeBloc>()),
      ],
      child: _EditEmployeePageBody(
        employeeId: employee!.id ?? 0,
        departmentName: departmentName,
      ),
    );
  }
}

class _EditEmployeePageBody extends StatelessWidget {
  const _EditEmployeePageBody({required this.employeeId, this.departmentName});

  final int employeeId;
  final String? departmentName;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final scheme = context.scheme;
    final isDesktop = Responsive.isDesktop(context);
    final showMenuButton = Scaffold.maybeOf(context)?.hasDrawer ?? false;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocListener<UpdateEmployeeBloc, UpdateEmployeeBlocState>(
        listener: (context, state) {
          if (state.status == UpdateEmployeeStatus.success) {
            DepartmentSnackbarHelper.showSuccess(
              context,
              title: isArabic ? 'تم بنجاح' : 'Success',
              message:
                  state.responseModel?.message ??
                  (isArabic
                      ? 'تم تحديث بيانات الموظف بنجاح'
                      : 'Employee updated successfully'),
            );
            context.read<DepartmentsWithEmployeeBloc>().add(
              const DepartmentsWithEmployeeFetchRequested(),
            );
            Navigator.of(context).pop(true);
            return;
          }

          if (state.status == UpdateEmployeeStatus.failure) {
            DepartmentSnackbarHelper.showFailure(
              context,
              title: isArabic
                  ? 'تعذر تحديث الموظف'
                  : 'Unable to update employee',
              message:
                  state.failure?.message ??
                  (isArabic
                      ? 'حدث خطأ أثناء تحديث الموظف'
                      : 'An error occurred while updating the employee'),
              failure: state.failure,
            );
          }
        },
        child:
            BlocBuilder<
              DepartmentsWithEmployeeBloc,
              DepartmentsWithEmployeeState
            >(
              builder: (context, departmentsState) {
                return BlocBuilder<RolesBloc, RolesBlocState>(
                  builder: (context, rolesState) {
                    final departmentsLoading =
                        departmentsState.isInitialLoading &&
                        departmentsState.departments.isEmpty;
                    final rolesLoading =
                        rolesState.isLoading && rolesState.roles.isEmpty;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        EditEmployeeTopBar(
                          breadcrumbs: [
                            AppBreadcrumbItem(
                              label: isArabic ? 'الأقسام' : 'Departments',
                              path: AppRoutePaths.labManagerEmployees,
                            ),
                            AppBreadcrumbItem(
                              label: isArabic ? 'تعديل موظف' : 'Edit employee',
                              isActive: true,
                            ),
                          ],
                          isArabic: isArabic,
                          scheme: scheme,
                          showMenuButton: showMenuButton,
                          onMenuTap: () =>
                              Scaffold.maybeOf(context)?.openDrawer(),
                          onCancel: () => Navigator.of(context).pop(),
                          onSave: (rolesLoading || departmentsLoading)
                              ? null
                              : () =>
                                    performEmployeeSubmit(context, employeeId),
                          isLoading: rolesLoading || departmentsLoading,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Flexible(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isMobile =
                                  !isDesktop || constraints.maxWidth < 980;

                              final profileCard = EditEmployeeProfileCard(
                                isArabic: isArabic,
                                onPickImage: () => _pickProfileImage(context),
                              );

                              final personalSection =
                                  EditEmployeePersonalSection(
                                    rolesState: rolesState,
                                    departmentsState: departmentsState,
                                  );

                              const securitySection =
                                  EditEmployeeSecuritySection();
                              const contactSection =
                                  EditEmployeeContactSection();

                              return SingleChildScrollView(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 1180,
                                      minHeight: isMobile
                                          ? 0
                                          : constraints.maxHeight,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        isMobile ? AppSpacing.lg : 56,
                                        isMobile ? AppSpacing.lg : 18,
                                        isMobile ? AppSpacing.lg : 56,
                                        AppSpacing.xl,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (isMobile)
                                            Column(
                                              children: [
                                                profileCard,
                                                const SizedBox(
                                                  height: AppSpacing.lg,
                                                ),
                                                personalSection,
                                              ],
                                            )
                                          else
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 240,
                                                  child: profileCard,
                                                ),
                                                const SizedBox(
                                                  width: AppSpacing.lg,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [personalSection],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          const SizedBox(height: AppSpacing.lg),
                                          if (isMobile) ...[
                                            securitySection,
                                            const SizedBox(
                                              height: AppSpacing.lg,
                                            ),
                                            contactSection,
                                          ] else ...[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Expanded(
                                                  child: securitySection,
                                                ),
                                                SizedBox(width: AppSpacing.lg),
                                                Expanded(child: contactSection),
                                              ],
                                            ),
                                          ],
                                          const SizedBox(height: AppSpacing.xl),
                                          if (isMobile)
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFF008080,
                                                ),
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () =>
                                                  performEmployeeSubmit(
                                                    context,
                                                    employeeId,
                                                  ),
                                              child: Text(
                                                isArabic
                                                    ? 'حفظ التغييرات'
                                                    : 'Save Changes',
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}

Future<void> _pickProfileImage(BuildContext context) async {
  final formCubit = context.read<UpdateEmployeeFormCubit>();
  formCubit.clearProfileImageError();
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true,
  );
  final file = result?.files.single;
  final bytes = file?.bytes;

  if (file == null || bytes == null) return;
  formCubit.setProfileImage(bytes: bytes, name: file.name);
}

void performEmployeeSubmit(BuildContext context, int employeeId) {
  final isArabic = context.isArabic;
  final formCubit = context.read<UpdateEmployeeFormCubit>();
  final formState = formCubit.state;

  final isValid = formCubit.validate(isArabic: isArabic);
  if (!isValid) return;

  final birthdateIso = AppValidators.normalizeMaskedDateToIso(
    formState.birthdate,
  );
  final joinedAtIso = AppValidators.normalizeMaskedDateToIso(
    formState.joinedAt,
  );

  if (birthdateIso == null || joinedAtIso == null) return;

  final isPasswordTouched =
      formState.password != '••••••••' && formState.password.trim().isNotEmpty;
  final cleanPassword = isPasswordTouched ? formState.password.trim() : '';
  final cleanConfirmPassword = isPasswordTouched
      ? formState.confirmPassword.trim()
      : '';

  final employeeEntity = EmployeeEntity(
    id: employeeId,
    name: formState.name.trim(),
    email: formState.email.trim(),
    phone: formState.phone.trim(),
    birthdate: birthdateIso,
    joinedAt: joinedAtIso,
    roleId: formState.roleId ?? 0,
    departmentIds: formState.departmentIds,
    password: cleanPassword,
    passwordConfirmation: cleanConfirmPassword,
    profileImageBytes: formState.profileImageBytes,
    profileImageName: formState.profileImageBytes != null
        ? formState.profileImageName
        : null,
    profileImagePath: null,
  );

  context.read<UpdateEmployeeBloc>().add(
    UpdateEmployeeSubmitted(employeeEntity),
  );
}
