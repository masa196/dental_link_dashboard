import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_event.dart';
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
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/create_employee/create_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/create_employee/create_employee_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/create_employee/create_employee_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/create_employee_contact_section.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/create_employee_personal_section.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/create_employee_profile_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/create_employee_security_section.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/widgets/create_employee_top_bar.dart';

class CreateEmployeePage extends StatelessWidget {
  const CreateEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CreateEmployeeFormCubit()),
        BlocProvider(create: (_) => locator<CreateEmployeeBloc>()),
      ],
      child: const _CreateEmployeePageBody(),
    );
  }
}

class _CreateEmployeePageBody extends StatelessWidget {
  const _CreateEmployeePageBody();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final scheme = context.scheme;
    final isDesktop = Responsive.isDesktop(context);
    final showMenuButton = Scaffold.maybeOf(context)?.hasDrawer ?? false;

    final departmentsBloc = context.read<DepartmentsWithEmployeeBloc>();
    final rolesBloc = context.read<RolesBloc>();

    // ✅ إصلاح جلب البيانات الاحتياطي عبر ترحيله لبعد انتهاء الـ Build Frame
    if (departmentsBloc.state.departments.isEmpty && !departmentsBloc.state.isInitialLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        departmentsBloc.add(const DepartmentsWithEmployeeFetchRequested());
      });
    }
    if (rolesBloc.state.roles.isEmpty && !rolesBloc.state.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        rolesBloc.add(const RolesFetchRequested());
      });
    }

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocListener<CreateEmployeeBloc, CreateEmployeeBlocState>(
        listener: (context, state) {
          if (state.status == CreateEmployeeStatus.success) {
            Navigator.of(context).pop(
              state.responseModel?.message ??
                  (isArabic ? 'تم إنشاء الموظف بنجاح' : 'Employee created successfully'),
            );
            return;
          }

          if (state.status == CreateEmployeeStatus.failure) {
            DepartmentSnackbarHelper.showFailure(
              context,
              title: isArabic ? 'تعذر إنشاء الموظف' : 'Unable to create employee',
              message: state.failure?.message ??
                  (isArabic
                      ? 'حدث خطأ أثناء إنشاء الموظف'
                      : 'An error occurred while creating the employee'),
              failure: state.failure,
            );
          }
        },
        child: BlocBuilder<DepartmentsWithEmployeeBloc, DepartmentsWithEmployeeState>(
          builder: (context, departmentsState) {
            return BlocBuilder<RolesBloc, RolesBlocState>(
              builder: (context, rolesState) {
                // ✅ نراقب أيضاً حالة تحميل الـ CreateEmployeeBloc لتعطيل الزر أثناء الإرسال
                return BlocBuilder<CreateEmployeeBloc, CreateEmployeeBlocState>(
                  builder: (context, createEmployeeState) {
                    final departmentsLoading = departmentsState.isInitialLoading && departmentsState.departments.isEmpty;
                    final rolesLoading = rolesState.isLoading && rolesState.roles.isEmpty;
                    final isSubmitting = createEmployeeState.status == CreateEmployeeStatus.loading;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CreateEmployeeTopBar(
                          breadcrumbs: [
                            AppBreadcrumbItem(
                              label: isArabic ? 'الأقسام' : 'Departments',
                              path: AppRoutePaths.labManagerEmployees,
                            ),
                            AppBreadcrumbItem(
                              label: isArabic ? 'إضافة موظف' : 'Add employee',
                              isActive: true,
                            ),
                          ],
                          isArabic: isArabic,
                          scheme: scheme,
                          showMenuButton: showMenuButton,
                          onMenuTap: () => Scaffold.maybeOf(context)?.openDrawer(),
                          onCancel: () => Navigator.of(context).pop(),
                          // ✅ الزر يتعطل إذا كانت البيانات الأساسية تُجلب، أو إذا كان يتم إرسال طلب الحفظ الآن
                          onSave: (rolesLoading || departmentsLoading || isSubmitting)
                              ? null
                              : () => _submit(context),
                          isLoading: rolesLoading || isSubmitting, // الحالات التي يظهر فيها الـ Spinner
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Flexible(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isMobile = !isDesktop || constraints.maxWidth < 980;
                              final profileCard = CreateEmployeeProfileCard(
                                isArabic: isArabic,
                                onPickImage: () => _pickProfileImage(context),
                              );
                              final personalSection = CreateEmployeePersonalSection(
                                rolesState: rolesState,
                                departmentsState: departmentsState,
                              );
                              const securitySection = CreateEmployeeSecuritySection();
                              const contactSection = CreateEmployeeContactSection();

                              return SingleChildScrollView(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 1180,
                                      minHeight: isMobile ? 0 : constraints.maxHeight,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        isMobile ? AppSpacing.lg : 56,
                                        isMobile ? AppSpacing.lg : 18,
                                        isMobile ? AppSpacing.lg : 56,
                                        AppSpacing.xl,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          if (isMobile) ...[
                                            profileCard,
                                            const SizedBox(height: AppSpacing.lg),
                                            personalSection,
                                          ] else ...[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 240, child: profileCard),
                                                const SizedBox(width: AppSpacing.lg),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [personalSection],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          const SizedBox(height: AppSpacing.lg),
                                          if (isMobile) ...[
                                            securitySection,
                                            const SizedBox(height: AppSpacing.lg),
                                            contactSection,
                                          ] else ...[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(child: securitySection),
                                                const SizedBox(width: AppSpacing.lg),
                                                Expanded(child: contactSection),
                                              ],
                                            ),
                                          ],
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
            );
          },
        ),
      ),
    );
  }

  // ✅ جعل الدالة متصلة بالـ Context الداخلي للـ Widget بشكل آمن
  Future<void> _pickProfileImage(BuildContext context) async {
    final formCubit = context.read<CreateEmployeeFormCubit>();
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

  // ✅ تأمين دالة الإرسال والتحقق
  void _submit(BuildContext context) {
    final isArabic = context.isArabic;
    final formCubit = context.read<CreateEmployeeFormCubit>();
    final formState = formCubit.state;

    final isValid = formCubit.validate(isArabic: isArabic);
    if (!isValid) return;

    final birthdateIso = AppValidators.normalizeMaskedDateToIso(formState.birthdate);
    final joinedAtIso = AppValidators.normalizeMaskedDateToIso(formState.joinedAt);

    if (formState.departmentIds.isEmpty ||
        formState.roleId == null ||
        birthdateIso == null ||
        joinedAtIso == null) {
      return;
    }

    context.read<CreateEmployeeBloc>().add(
          CreateEmployeeSubmitted(
            EmployeeEntity(
              name: formState.name.trim(),
              email: formState.email.trim(),
              password: formState.password,
              passwordConfirmation: formState.confirmPassword,
              birthdate: birthdateIso,
              joinedAt: joinedAtIso,
              departmentIds: formState.departmentIds,
              roleId: formState.roleId!,
              phone: formState.phone.trim(),
              profileImageBytes: formState.profileImageBytes,
              profileImageName: formState.profileImageName,
              profileImagePath: formState.profileImagePath,
            ),
          ),
        );
  }
}