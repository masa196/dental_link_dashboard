import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/get_order_stages/get_order_stages_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/get_order_stages/get_order_stages_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/update_order_stages/update_order_stages_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/manage_order_stages/order_stages_dialog.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/widgets/delete_department_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/widgets/edit_department_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/widgets/create_departments_dialog.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class DepartmentsPage extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenu;

  const DepartmentsPage({super.key, this.onMenuTap, this.showMenu = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final theme = Theme.of(context);
    final scheme = context.scheme;
    final isArabic = context.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body:
            BlocBuilder<
              DepartmentsWithEmployeeBloc,
              DepartmentsWithEmployeeState
            >(
              builder: (context, state) {
                // أ. حالة التحميل الأولي
                if (state.isInitialLoading ||
                    (state.status == DepartmentsWithEmployeeStatus.initial &&
                        !state.hasData)) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ب. حالة الفشل في جلب البيانات
                if (state.status == DepartmentsWithEmployeeStatus.failure) {
                  return Center(
                    child: _EmptyDepartmentsState(
                      scheme: scheme,
                      message:
                          state.failure?.message ??
                          (isArabic
                              ? 'تعذر تحميل الأقسام الآن'
                              : 'Unable to load departments right now'),
                    ),
                  );
                }

                // ج. شاشة الحالة الفارغة (نجح الطلب ولكن لا توجد بيانات)
                if (state.status == DepartmentsWithEmployeeStatus.success &&
                    !state.hasData) {
                  return Center(
                    child: _EmptyDepartmentsState(
                      scheme: scheme,
                      message: isArabic
                          ? 'أنشئ أقسام مخبرك الان واضف موظفي المخبر لبدأ العمل'
                          : 'Create your lab sections now and add lab staff to get started',
                    ),
                  );
                }

                // د. عرض الواجهة الطبيعية عند وجود البيانات واستقرارها
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DashboardHeader(
                      showSearchBar: false,
                      title: isArabic
                          ? 'دليل الموظفين والأقسام'
                          : 'Employees & Departments',

                      showMenuButton: !Responsive.isDesktop(context),

                      trailing: Wrap(
                        spacing: AppSpacing.md,

                        children: [
                          OutlinedButton.icon(
                            onPressed: () => _openOrderStagesDialog(
                              context,
                              state.departments,
                            ),
                            icon: const Icon(Icons.route_outlined),
                            label: Text(
                              isArabic ? 'مراحل الطلبية' : 'Order Workflow',
                            ),
                          ),

                          ElevatedButton.icon(
                            onPressed: () => _handleCreateDepartment(context),

                            icon: const Icon(Icons.add),

                            label: Text(isArabic ? 'إضافة قسم' : 'Add Section'),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: scheme.primary,
                              foregroundColor: scheme.onPrimary,

                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                              ),
                            ),
                          ),

                          OutlinedButton.icon(
                            onPressed: () => _openCreateEmployeePage(
                              context,
                              departments: state.departments,
                            ),

                            icon: const Icon(Icons.person_add_alt_1),

                            label: Text(
                              isArabic ? 'إضافة موظف' : 'Add Employee',
                            ),

                            style: OutlinedButton.styleFrom(
                              foregroundColor: scheme.primary,

                              side: BorderSide(
                                color: scheme.primary.withValues(alpha: 0.35),
                              ),

                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    Divider(color: theme.dividerColor, thickness: 1),

                    const SizedBox(height: AppSpacing.lg),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (final d in state.departments) ...[
                              _DepartmentSection(
                                department: d,

                                scheme: scheme,

                                isArabic: isArabic,

                                isMobile: isMobile,

                                onEditDepartment: () =>
                                    _handleEditDepartment(context, d),

                                onDeleteDepartment: () =>
                                    _handleDeleteDepartment(context, d),

                                onViewAllEmployees: () =>
                                    _openEmployeePage(context, d),
                              ),

                              const SizedBox(height: AppSpacing.xl),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }

  Future<void> _openOrderStagesDialog(
    BuildContext context,
    List<DepartmentItem> departments,
  ) async {
    final getOrderStagesBloc = context.read<GetOrderStagesBloc>();

    getOrderStagesBloc.add(const GetOrderStagesRequested());

    await showDialog(
      context: context,
      barrierDismissible: false,

      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: getOrderStagesBloc),

            BlocProvider(create: (_) => locator<UpdateOrderStagesBloc>()),
          ],

          child: OrderStagesDialog(departments: departments),
        );
      },
    );
  }

  Future<void> _handleCreateDepartment(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CreateDepartmentsDialog(),
    );

    if (result != null && context.mounted) {
      _refreshDepartments(context);
      DepartmentSnackbarHelper.showSuccess(
        context,
        title: context.isArabic ? 'تم إنشاء القسم' : 'Department created',
        message: result,
      );
    }
  }

  Future<void> _handleEditDepartment(
    BuildContext context,
    DepartmentItem department,
  ) async {
    final departmentId = department.id;
    if (departmentId == null) return;

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditDepartmentDialog(
        departmentId: departmentId,
        initialName: department.name ?? '',
      ),
    );

    if (result != null && context.mounted) {
      _refreshDepartments(context);
      DepartmentSnackbarHelper.showSuccess(
        context,
        title: context.isArabic ? 'تم تعديل القسم' : 'Department updated',
        message: result,
      );
    }
  }

  Future<void> _handleDeleteDepartment(
    BuildContext context,
    DepartmentItem department,
  ) async {
    final departmentId = department.id;
    if (departmentId == null) return;

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => DeleteDepartmentDialog(
        departmentId: departmentId,
        departmentName:
            department.name ??
            (context.isArabic ? 'قسم بدون اسم' : 'Untitled section'),
      ),
    );

    if (result != null && context.mounted) {
      _refreshDepartments(context);
      DepartmentSnackbarHelper.showSuccess(
        context,
        title: context.isArabic ? 'تم حذف القسم' : 'Department deleted',
        message: result,
      );
    }
  }

  Future<void> _openEmployeePage(
    BuildContext context,
    DepartmentItem department,
  ) async {
    final departmentId = department.id;
    if (departmentId == null) return;

    // 👈 1. نقوم باستقبال النتيجة كـ bool (والتي يرسلها الـ Notifier عند الخروج)
    final isChanged = await EmployeePageRoute(
      departmentId: departmentId,
      departmentName: department.name,
      $extra: EmployeePageRouteExtra(
        departmentsBloc: context.read<DepartmentsWithEmployeeBloc>(),
        rolesBloc: context.read<RolesBloc>(),
      ),
    ).push<bool>(context); // 👈 حددنا نوع القيمة المرتجعة هنا لتكون bool

    // 👈 2. نتحقق: إذا عادت القيمة بـ true والسياق ما زال موجوداً، نقوم بتحديث صفحة الأقسام
    if (isChanged == true && context.mounted) {
      _refreshDepartments(context);
    }
  }

  void _refreshDepartments(BuildContext context) {
    context.read<DepartmentsWithEmployeeBloc>().add(
      const DepartmentsWithEmployeeFetchRequested(),
    );
  }

  Future<void> _openCreateEmployeePage(
    BuildContext context, {
    required List<DepartmentItem> departments,
  }) async {
    final result = await CreateEmployeeRoute(
      $extra: CreateEmployeeRouteExtra(
        departmentsBloc: context.read<DepartmentsWithEmployeeBloc>(),
        rolesBloc: context.read<RolesBloc>(),
      ),
    ).push<String>(context);

    if (result != null && context.mounted) {
      _refreshDepartments(context);
      DepartmentSnackbarHelper.showSuccess(
        context,
        title: context.isArabic ? 'تم إنشاء الموظف' : 'Employee created',
        message: result,
      );
    }
  }
}

class _DepartmentSection extends StatelessWidget {
  const _DepartmentSection({
    required this.department,
    required this.scheme,
    required this.isArabic,
    required this.isMobile,
    this.onEditDepartment,
    this.onDeleteDepartment,
    this.onViewAllEmployees,
  });

  final DepartmentItem department;
  final ColorScheme scheme;
  final bool isArabic;
  final bool isMobile;
  final VoidCallback? onEditDepartment;
  final VoidCallback? onDeleteDepartment;
  final VoidCallback? onViewAllEmployees;

  @override
  Widget build(BuildContext context) {
    final employees = department.employees?.data ?? const [];
    final title =
        department.name ?? (isArabic ? 'قسم بدون اسم' : 'Untitled section');
    final managerIndex = employees.indexWhere(
      (e) => e.role?.name == 'department_manager',
    );
    final EmployeesDatum? manager = managerIndex >= 0
        ? employees[managerIndex]
        : null;
    final staff = manager == null
        ? List<EmployeesDatum>.from(employees)
        : employees.where((e) => e.id != manager.id).toList(growable: false);
    final totalCount = manager != null ? 1 + staff.length : staff.length;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // لضمان تمدد العناصر عرضياً
      children: [
        _DepartmentHeader(
          title: title,
          scheme: scheme,
          isArabic: isArabic,
          hasEmployees: employees.isNotEmpty,
          onEditTap: onEditDepartment, // تمرير الحدث
          onDeleteTap: onDeleteDepartment, // تمرير الحدث
          onViewAllTap: onViewAllEmployees,
        ),
        const SizedBox(height: AppSpacing.md),
        if (totalCount == 0)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Container(
                height: 124,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: scheme.outlineVariant.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      size: 20,
                      color: scheme.onSurface.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      isArabic
                          ? 'لا يوجد موظفين في هذا القسم حالياً'
                          : 'No employees in this department yet',
                      style: TextStyle(
                        fontSize: AppTypography.fs13,
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 124,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: totalCount,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
              itemBuilder: (context, index) {
                final EmployeesDatum employee = manager != null
                    ? (index == 0 ? manager : staff[index - 1])
                    : staff[index];
                final isManager = employee.role?.name == 'department_manager';
                return SizedBox(
                  width: isMobile
                      ? MediaQuery.of(context).size.width - 48
                      : 320,
                  child: _EmployeeCompactCard(
                    employee: employee,
                    scheme: scheme,
                    isArabic: isArabic,
                    isManager: isManager,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _DepartmentHeader extends StatelessWidget {
  const _DepartmentHeader({
    required this.title,
    required this.scheme,
    required this.isArabic,
    required this.hasEmployees,
    this.onEditTap,
    this.onDeleteTap,
    this.onViewAllTap,
  });

  final String title;
  final ColorScheme scheme;
  final bool isArabic;
  final bool hasEmployees;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: scheme.onSurface.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // 1. أيقونة خيارات القسم التفاعلية (بديلة لأيقونة السحب وأزرار العمليات المباشرة)
            PopupMenuButton<String>(
              tooltip: isArabic ? 'خيارات القسم' : 'Department options',
              icon: Icon(
                Icons
                    .more_vert_rounded, // أيقونة الخيارات العمودية الأنسب للقوائم المنبثقة
                size: 22,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
              onSelected: (value) {
                if (value == 'edit' && onEditTap != null) {
                  onEditTap!();
                } else if (value == 'delete' && onDeleteTap != null) {
                  onDeleteTap!();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                // خيار التعديل
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_rounded, size: 18, color: scheme.primary),
                      const SizedBox(width: 10),
                      Text(
                        isArabic ? 'تعديل اسم القسم' : 'Edit department name',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(height: 1), // خط فاصل ناعم بين الخيارات
                // خيار الحذف
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        size: 18,
                        color: scheme.error,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isArabic ? 'حذف القسم' : 'Delete department',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: scheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),

            // 2. اسم القسم
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: scheme.onSurface,
                letterSpacing: isArabic ? 0 : 0.5,
              ),
            ),
            const SizedBox(width: 12),

            // 3. شارة حالة القسم (نشط / فارغ)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: hasEmployees
                    ? scheme.primary.withValues(alpha: 0.1)
                    : scheme.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                hasEmployees
                    ? (isArabic ? 'نشط' : 'Active')
                    : (isArabic ? 'فارغ' : 'Empty'),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: hasEmployees ? scheme.primary : scheme.error,
                ),
              ),
            ),

            // يدفع زر "عرض الكل" ديناميكياً لأقصى الطرف الآخر بحسب اتجاه اللغة
            const Spacer(),

            // 4. زر "عرض الكل" التفاعلي (يظهر فقط إذا كان القسم يحتوي على موظفين)
            if (hasEmployees)
              InkWell(
                onTap: onViewAllTap,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isArabic ? 'عرض كل الموظفين' : 'View all  employees',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isArabic
                            ? Icons.arrow_left_rounded
                            : Icons.arrow_right_rounded,
                        size: 20,
                        color: scheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EmployeeCompactCard extends StatelessWidget {
  const _EmployeeCompactCard({
    required this.employee,
    required this.scheme,
    required this.isArabic,
    required this.isManager,
  });

  final EmployeesDatum employee;
  final ColorScheme scheme;
  final bool isArabic;
  final bool isManager;

  @override
  Widget build(BuildContext context) {
    final name =
        employee.name ?? (isArabic ? 'اسم غير متوفر' : 'Unnamed employee');
    final phone = employee.phone ?? '-';
    final imageUrl = _resolveImageUrl(employee.profileImage);
    final theme = Theme.of(context);
    final cardShadowColor = theme.brightness == Brightness.dark
        ? scheme.shadow.withValues(alpha: 0.35)
        : scheme.shadow.withValues(alpha: 0.08);

    return Card(
      elevation: 0,
      color: scheme.surface,
      shadowColor: cardShadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(
          color: isManager ? scheme.primary : scheme.outlineVariant,
          width: isManager ? 1.4 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Stack(
          children: [
            if (isManager)
              PositionedDirectional(
                top: 0,
                end: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: const BorderRadiusDirectional.only(
                      topEnd: Radius.circular(AppRadius.lg),
                      bottomStart: Radius.circular(AppRadius.sm),
                    ),
                  ),
                  child: Text(
                    isArabic ? 'مدير القسم' : 'Department Manager',
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppTypography.fs10,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Row(
                children: [
                  _EmployeeAvatar(
                    name: name,
                    imageUrl: imageUrl,
                    scheme: scheme,
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: AppTypography.fs14,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: AppTypography.fs12,
                            color: scheme.onSurface.withValues(alpha: 0.72),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _resolveImageUrl(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final baseUri = Uri.parse(
      ApiEndpoints.baseUrl.endsWith('/')
          ? ApiEndpoints.baseUrl
          : '${ApiEndpoints.baseUrl}/',
    );
    return baseUri.resolve(raw).toString();
  }
}

class _EmployeeAvatar extends StatelessWidget {
  const _EmployeeAvatar({
    required this.name,
    required this.imageUrl,
    required this.scheme,
  });

  final String name;
  final String? imageUrl;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(name);
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl == null
          ? Center(
              child: Text(
                initials,
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          : Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
    );
  }

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return String.fromCharCode(parts.first.runes.first).toUpperCase();
    }
    final first = String.fromCharCode(parts.first.runes.first);
    final second = String.fromCharCode(parts[1].runes.first);
    return '$first$second'.toUpperCase();
  }
}

class _EmptyDepartmentsState extends StatelessWidget {
  const _EmptyDepartmentsState({required this.scheme, required this.message});

  final ColorScheme scheme;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppTypography.fs14,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface.withValues(alpha: 0.72),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
