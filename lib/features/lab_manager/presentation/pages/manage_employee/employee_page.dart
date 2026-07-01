import 'dart:math' as math;

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/delete_employee/delete_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/delete_employee/delete_employee_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/delete_employee/delete_employee_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/edit_employee/edit_employee_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/navigation/app_breadcrumbs.dart';
import 'package:dental_link_dashboard/core/navigation/app_route_paths.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_employee/show_employee_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/show_employee/employee_page_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/show_employee/employee_page_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/show_employee/employee_page_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';

class EmployeePage extends StatelessWidget {
  EmployeePage({super.key});

  final isDataChangedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;
    final isDesktop = Responsive.isDesktop(context);
    final showMenuButton = Scaffold.maybeOf(context)?.hasDrawer ?? false;

    return Builder(
      builder: (context) {
        return BlocProvider<DeleteEmployeeBloc>(
          create: (context) => locator<DeleteEmployeeBloc>(),
          child: Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: BlocBuilder<EmployeePageBloc, EmployeePageState>(
              builder: (context, state) {
                final shouldShowError =
                    state.status == EmployeePageStatus.failure &&
                    !state.hasData;
                final totalEmployeesText = state.totalEmployees;

                return Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _EmployeeTopBar(
                        state: state,
                        totalEmployeesText: totalEmployeesText,
                        isArabic: isArabic,
                        scheme: scheme,
                        isDesktop: isDesktop,
                        showMenuButton: showMenuButton,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Flexible(
                        child: state.isInitialLoading
                            ? const Center(child: CircularProgressIndicator())
                            : shouldShowError
                            ? _EmployeeErrorState(
                                message:
                                    state.failure?.message ??
                                    (isArabic
                                        ? 'تعذر تحميل الموظفين الآن'
                                        : 'Unable to load employees right now'),
                                onRetry: () =>
                                    context.read<EmployeePageBloc>().add(
                                      EmployeePageFetchRequested(
                                        departmentId: state.departmentId,
                                        page: state.currentPage,
                                        employeesPerPage:
                                            state.employeesPerPage,
                                      ),
                                    ),
                              )
                            : _EmployeeContent(
                                key: ValueKey('page-${state.currentPage}'),
                                state: state,
                                scheme: scheme,
                                isArabic: isArabic,
                                isDataChangedNotifier: isDataChangedNotifier,
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _EmployeeTopBar extends StatelessWidget {
  const _EmployeeTopBar({
    required this.state,
    required this.totalEmployeesText,
    required this.isArabic,
    required this.scheme,
    required this.isDesktop,
    required this.showMenuButton,
  });

  final EmployeePageState state;
  final int? totalEmployeesText;
  final bool isArabic;
  final ColorScheme scheme;
  final bool isDesktop;
  final bool showMenuButton;

  @override
  Widget build(BuildContext context) {
    final totalEmployeesSuffix = totalEmployeesText == null
        ? ''
        : ' : $totalEmployeesText';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = !isDesktop || constraints.maxWidth < 980;

          // للشاشات الصغيرة والمتوسطة (Responsive Mobile/Tablet)
          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    if (showMenuButton)
                      IconButton(
                        onPressed: () =>
                            Scaffold.maybeOf(context)?.openDrawer(),
                        icon: const Icon(Icons.menu_rounded),
                        color: scheme.onSurfaceVariant,
                      ),
                    Expanded(
                      child: _Breadcrumbs(state: state, isArabic: isArabic),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                // النص المدمج الجديد في الشاشات الصغيرة
                Text(
                  isArabic
                      ? 'إجمالي موظفي قسم ${state.title}$totalEmployeesSuffix'
                      : 'Total employees in ${state.title} department$totalEmployeesSuffix',
                  style: TextStyle(
                    fontSize: AppTypography.fs18,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _SearchBar(isArabic: isArabic, scheme: scheme),
              ],
            );
          }

          // للتصميم العريض الموحد (Desktop Standard)
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // الطرف الأول: زر القائمة + الـ Breadcrumbs + النص المدمج في سطر واحد
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    if (showMenuButton)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        child: IconButton(
                          onPressed: () =>
                              Scaffold.maybeOf(context)?.openDrawer(),
                          icon: const Icon(Icons.menu_rounded),
                          style: IconButton.styleFrom(
                            foregroundColor: scheme.onSurfaceVariant,
                            minimumSize: const Size(40, 40),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Breadcrumbs(state: state, isArabic: isArabic),
                          const SizedBox(height: 6),
                          // السطر الموحد الجديد والمطابق لطلبك
                          Text(
                            isArabic
                                ? 'إجمالي موظفي قسم ${state.title}$totalEmployeesSuffix'
                                : 'Total employees in ${state.title} department$totalEmployeesSuffix',
                            style: TextStyle(
                              fontSize: AppTypography.fs18, // حجم متناسق للويب
                              fontWeight: FontWeight.w700, // خط عريض وواضح
                              color: scheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 32),

              // الطرف الثاني: شريط البحث محاذى للطرف المقابل
              Expanded(
                flex: 3,
                child: Align(
                  alignment: isArabic
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: _SearchBar(isArabic: isArabic, scheme: scheme),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Breadcrumbs extends StatelessWidget {
  const _Breadcrumbs({required this.state, required this.isArabic});

  final EmployeePageState state;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return AppBreadcrumbs(
      items: [
        AppBreadcrumbItem(
          label: isArabic ? 'الأقسام' : 'Departments',
          path: AppRoutePaths.labManagerEmployees,
        ),
        AppBreadcrumbItem(label: state.title, isActive: true),
      ],
    );
  }
}

class _EmployeeContent extends StatelessWidget {
  const _EmployeeContent({
    super.key,
    required this.state,
    required this.scheme,
    required this.isArabic,
    required this.isDataChangedNotifier, //
  });
  final ValueNotifier<bool> isDataChangedNotifier;
  final EmployeePageState state;
  final ColorScheme scheme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final viewportHeight = MediaQuery.sizeOf(context).height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? math.max(0.0, constraints.maxHeight - 2.0)
            : viewportHeight - 240;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _EmployeeTableCard(
              state: state,
              scheme: scheme,
              isArabic: isArabic,
              maxHeight: availableHeight,
              isDataChangedNotifier: isDataChangedNotifier,
            ),
            if (state.status == EmployeePageStatus.failure &&
                state.hasData) ...[
              const SizedBox(height: AppSpacing.md),
              _InlineFailureBanner(
                message:
                    state.failure?.message ??
                    (isArabic
                        ? 'حدث خطأ أثناء تحميل الصفحة الحالية'
                        : 'An error occurred while loading the current page'),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.isArabic, required this.scheme});

  final bool isArabic;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 500,
      child: TextField(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        decoration: InputDecoration(
          hintText: isArabic ? 'بحث عن موظف...' : 'Search for an employee...',
          suffixIcon: isArabic ? const Icon(Icons.search_rounded) : null,
          prefixIcon: isArabic ? null : const Icon(Icons.search_rounded),
          filled: true,
          fillColor: scheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.xs),
            borderSide: BorderSide(
              color: scheme.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.xs),
            borderSide: BorderSide(
              color: scheme.outlineVariant.withValues(alpha: 0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.xs),
            borderSide: BorderSide(color: scheme.primary, width: 1.6),
          ),
        ),
      ),
    );
  }
}

class _EmployeeTableCard extends StatelessWidget {
  static const Map<int, TableColumnWidth> _columnWidths = {
    0: FixedColumnWidth(100),
    1: FlexColumnWidth(0.5),
    2: FixedColumnWidth(130),
    3: FlexColumnWidth(0.5),
    4: FixedColumnWidth(150),
    5: FixedColumnWidth(130),
    6: FixedColumnWidth(110),
  };

  const _EmployeeTableCard({
    required this.state,
    required this.scheme,
    required this.isArabic,
    required this.maxHeight,
    required this.isDataChangedNotifier,
  });

  final EmployeePageState state;
  final ColorScheme scheme;
  final bool isArabic;
  final double maxHeight;
  final ValueNotifier<bool> isDataChangedNotifier;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).dividerColor.withValues(alpha: 0.8);
    final employees = state.employees;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tableWidth = math.max(constraints.maxWidth, 1000.0);
          final tableHeight = math.max(0.0, maxHeight);

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              height: tableHeight,
              child: Column(
                children: [
                  Container(
                    color: scheme.primary.withValues(alpha: 0.06),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: 18,
                    ),
                    child: _EmployeeTableHeader(
                      isArabic: isArabic,
                      scheme: scheme,
                    ),
                  ),

                  // rows (no animations)
                  Expanded(
                    child: ListView.separated(
                      key: ValueKey(state.currentPage), // مهم جداً
                      physics: const ClampingScrollPhysics(),
                      itemCount: employees.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        thickness: 1,
                        color: borderColor.withValues(alpha: 0.5),
                      ),
                      itemBuilder: (context, index) {
                        final emp = employees[index];

                        return _EmployeeTableRow(
                          employee: emp,
                          scheme: scheme,
                          isArabic: isArabic,
                          isDataChangedNotifier: isDataChangedNotifier,
                        );
                      },
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: borderColor.withValues(alpha: 0.45),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: _PaginationFooter(
                      state: state,
                      scheme: scheme,
                      isArabic: isArabic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmployeeTableHeader extends StatelessWidget {
  const _EmployeeTableHeader({required this.isArabic, required this.scheme});

  final bool isArabic;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: AppTypography.fs14,
      fontWeight: FontWeight.w700,
      color: scheme.onSurface.withValues(alpha: 0.8),
    );

    final direction = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Table(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      columnWidths: _EmployeeTableCard._columnWidths,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            _HeaderTextCell(
              label: isArabic ? 'الصورة' : 'Photo',
              textStyle: textStyle,
              alignment: Alignment.center,
            ),

            _HeaderTextCell(
              label: isArabic ? 'الاسم الكامل' : 'Full Name',
              textStyle: textStyle,
              alignment: direction == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
            _HeaderTextCell(
              label: isArabic ? 'تاريخ الميلاد' : 'Birth Date',
              textStyle: textStyle,
              alignment: direction == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
            _HeaderTextCell(
              label: isArabic ? 'البريد الإلكتروني' : 'Email',
              textStyle: textStyle,
              alignment: direction == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
            _HeaderTextCell(
              label: isArabic ? 'رقم الجوال' : 'Phone',
              textStyle: textStyle,
              alignment: direction == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
            _HeaderTextCell(
              label: isArabic ? 'تاريخ الانضمام' : 'Joined Date',
              textStyle: textStyle,
              alignment: direction == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
            _HeaderTextCell(
              label: isArabic ? 'الإجراءات' : 'Actions',
              textStyle: textStyle,
              alignment: Alignment.center,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderTextCell extends StatelessWidget {
  const _HeaderTextCell({
    required this.label,
    required this.textStyle,
    required this.alignment,
  });

  final String label;
  final TextStyle textStyle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: SizedBox(
        height: 30,
        child: Align(
          alignment: alignment,
          child: Text(label, style: textStyle),
        ),
      ),
    );
  }
}

class _EmployeeTableRow extends StatelessWidget {
  const _EmployeeTableRow({
    required this.employee,
    required this.scheme,
    required this.isArabic,
    required this.isDataChangedNotifier,
  });
  final ValueNotifier<bool> isDataChangedNotifier;
  final EmployeesDatum employee;
  final ColorScheme scheme;
  final bool isArabic;

  bool get isManager => employee.role?.name == 'department_manager';

  @override
  Widget build(BuildContext context) {
    final background = isManager ? scheme.primary : scheme.surface;
    final textColor = isManager ? scheme.onPrimary : scheme.onSurface;
    final secondaryColor = isManager
        ? scheme.onPrimary.withValues(alpha: 0.84)
        : scheme.onSurface.withValues(alpha: 0.72);

    return Container(
      height: 64,
      color: background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Table(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          columnWidths: _EmployeeTableCard._columnWidths,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                _RowCell(
                  alignment: Alignment.center,
                  child: _PhotoCell(
                    employee: employee,
                    scheme: scheme,
                    isArabic: isArabic,
                    isManager: isManager,
                  ),
                ),
                _RowCell(
                  alignment: isArabic
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: _NameCell(
                    employee: employee,
                    textColor: textColor,
                    secondaryColor: secondaryColor,
                    scheme: scheme,
                    isArabic: isArabic,
                    isManager: isManager,
                  ),
                ),
                _RowCell(
                  alignment: isArabic
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: _TextCell(
                    value: _formatDate(employee.birthdate),
                    color: textColor,
                    isArabic: isArabic,
                  ),
                ),
                _RowCell(
                  alignment: isArabic
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: _TextCell(
                    value: employee.email ?? '-',
                    color: textColor,
                    isArabic: isArabic,
                  ),
                ),
                _RowCell(
                  alignment: isArabic
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: _TextCell(
                    value: employee.phone ?? '-',
                    color: textColor,
                    isArabic: isArabic,
                  ),
                ),
                _RowCell(
                  alignment: isArabic
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: _TextCell(
                    value: _formatDate(employee.joinedAt),
                    color: textColor,
                    isArabic: isArabic,
                  ),
                ),
                _RowCell(
                  alignment: Alignment.center,
                  child: _ActionsCell(
                    employee: employee,
                    isManager: isManager,
                    scheme: scheme,
                    isArabic: isArabic,
                    isDataChangedNotifier: isDataChangedNotifier,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}

class _PhotoCell extends StatelessWidget {
  const _PhotoCell({
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
    final imageUrl = _resolveImageUrl(employee.profileImage);

    return CircleAvatar(
      radius: 20,
      backgroundColor: isManager
          ? scheme.onPrimary.withValues(alpha: 0.16)
          : scheme.primary.withValues(alpha: 0.12),
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
      child: imageUrl == null
          ? Icon(
              Icons.person_rounded,
              color: isManager ? scheme.onPrimary : scheme.primary,
            )
          : null,
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

class _NameCell extends StatelessWidget {
  const _NameCell({
    required this.employee,
    required this.textColor,
    required this.secondaryColor,
    required this.scheme,
    required this.isArabic,
    required this.isManager,
  });

  final EmployeesDatum employee;
  final Color textColor;
  final Color secondaryColor;
  final ColorScheme scheme;
  final bool isArabic;
  final bool isManager;

  @override
  Widget build(BuildContext context) {
    final name =
        employee.name ?? (isArabic ? 'اسم غير متوفر' : 'Unnamed employee');

    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
              fontSize: AppTypography.fs13,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          if (isManager)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: scheme.onPrimary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isArabic ? 'مدير القسم' : 'Department Manager',
                style: TextStyle(
                  color: textColor,
                  fontSize: AppTypography.fs10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else
            Text(
              employee.role?.name ?? (isArabic ? 'موظف' : 'Employee'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: secondaryColor,
                fontSize: AppTypography.fs12,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

class _TextCell extends StatelessWidget {
  const _TextCell({
    required this.value,
    required this.color,
    required this.isArabic,
  });

  final String value;
  final Color color;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final content = Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: AppTypography.fs13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return content;
  }
}

class _RowCell extends StatelessWidget {
  const _RowCell({required this.child, this.alignment = Alignment.center});

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}

class _ActionsCell extends StatelessWidget {
  const _ActionsCell({
    required this.employee,
    required this.isManager,
    required this.scheme,
    required this.isArabic,
    required this.isDataChangedNotifier,
  });
  final ValueNotifier<bool> isDataChangedNotifier; //
  final EmployeesDatum employee;
  final bool isManager;
  final ColorScheme scheme;
  final bool isArabic;

  // دالة مساعدة لتحويل الـ DateTime لـ String متوافق مع الحقول لديك
  String _formatDateTimeToString(DateTime? dateTime) {
    if (dateTime == null) return '';
    return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = isManager ? scheme.onPrimary : scheme.primary;
    final destructiveColor = isManager
        ? scheme.onPrimary
        : const Color(0xFFE53935);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionIcon(
          icon: Icons.delete_outline_rounded,
          color: destructiveColor,
          backgroundColor: isManager
              ? scheme.onPrimary.withValues(alpha: 0.12)
              : destructiveColor.withValues(alpha: 0.12),
          onTap: () {
            final deleteBloc = context.read<DeleteEmployeeBloc>();
            _showDeleteConfirmationDialog(context, employee.id!, deleteBloc);
          },
        ),
        const SizedBox(width: 8),
        _ActionIcon(
          icon: Icons.edit_outlined,
          color: iconColor,
          backgroundColor: isManager
              ? scheme.onPrimary.withValues(alpha: 0.12)
              : scheme.primary.withValues(alpha: 0.12),
          onTap: () {
            // 1. جلب نسخة الـ Blocs والحالة الحالية لصفحة الموظفين
            final rolesBloc = context.read<RolesBloc>();
            final deptsBloc = context.read<DepartmentsWithEmployeeBloc>();
            final pageBlocState = context.read<EmployeePageBloc>().state;

            // 2. بناء الـ Entity ومطابقة البيانات
            final employeeEntity = EmployeeEntity(
              id: employee.id,
              name: employee.name ?? '',
              email: employee.email ?? '',
              phone: employee.phone ?? '',
              birthdate: _formatDateTimeToString(employee.birthdate),
              joinedAt: _formatDateTimeToString(employee.joinedAt),
              roleId: employee.role?.id ?? 0,

              // الحل هنا: نمرر معرف القسم الحالي داخل المصفوفة لكي يرسل تلقائياً إذا لم يعدل عليه المستخدم
              departmentIds: [pageBlocState.departmentId],

              profileImagePath: employee.profileImage ?? '',
              password: '',
              passwordConfirmation: '',
            );

            // 3. الانتقال الطبيعي مع حقن الـ Blocs دون تغيير الـ Breadcrumbs
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<RolesBloc>.value(value: rolesBloc),
                    BlocProvider<DepartmentsWithEmployeeBloc>.value(
                      value: deptsBloc,
                    ),
                  ],
                  child: EditEmployeePage(employee: employeeEntity),
                ),
              ),
            ).then((value) {
              if (value == true && context.mounted) {
                isDataChangedNotifier.value = true;
                context.read<EmployeePageBloc>().add(
                  EmployeePageFetchRequested(
                    departmentId: context
                        .read<EmployeePageBloc>()
                        .state
                        .departmentId,
                    page: context.read<EmployeePageBloc>().state.currentPage,
                    employeesPerPage: context
                        .read<EmployeePageBloc>()
                        .state
                        .employeesPerPage,
                  ),
                );
              }
            });
          },
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    this.onTap, // إضافة حدث النقرة
  });

  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 15, color: color),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(
  BuildContext context,
  int employeeId,
  DeleteEmployeeBloc deleteBloc,
) {
  final employeePageBloc = context.read<EmployeePageBloc>();
  final departmentsBloc = context.read<DepartmentsWithEmployeeBloc>();
  final isArabic = context.isArabic; // جلب حالة اللغة المعتمدة في واجهتك

  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocConsumer<DeleteEmployeeBloc, DeleteEmployeeBlocState>(
        bloc: deleteBloc,
        listener: (context, state) {
          if (state.status == DeleteEmployeeStatus.success) {
            Navigator.of(dialogContext).pop();

            AppSnackbarHelper.showSuccess(
              context,
              title: isArabic ? 'عملية ناجحة' : 'Success',
              message: isArabic
                  ? 'تم حذف الموظف بنجاح'
                  : 'Employee deleted successfully',
            );

            // تحديث صفحة الموظفين
            employeePageBloc.add(
              EmployeePageFetchRequested(
                departmentId: employeePageBloc.state.departmentId,
                page: employeePageBloc.state.currentPage,
                employeesPerPage: employeePageBloc.state.employeesPerPage,
              ),
            );

            departmentsBloc.add(const DepartmentsWithEmployeeFetchRequested());

            deleteBloc.add(const DeleteEmployeeReset());
          } else if (state.status == DeleteEmployeeStatus.failure) {
            // استخدام الـ Helper المخصص لرسالة الفشل وتمرير الـ failure لعرض التفاصيل إن وجدت
            AppSnackbarHelper.showFailure(
              context,
              title: isArabic ? 'فشلت العملية' : 'Error',
              message:
                  state.failure?.message ??
                  (isArabic
                      ? 'حدث خطأ أثناء حذف الموظف'
                      : 'An error occurred while deleting the employee'),
              failure: state
                  .failure, // تمرير كائن الخطأ لمعالجة أخطاء الـ Validation تلقائياً
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == DeleteEmployeeStatus.loading;

          return AlertDialog(
            title: Text(isArabic ? 'تأكيد الحذف' : 'Confirm Delete'),
            content: isLoading
                ? const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Text(
                    isArabic
                        ? 'هل أنت متأكد من أنك تريد حذف هذا الموظف نهائياً؟'
                        : 'Are you sure you want to permanently delete this employee?',
                  ),
            actions: [
              TextButton(
                onPressed: isLoading
                    ? null
                    : () => Navigator.of(dialogContext).pop(),
                child: Text(isArabic ? 'إلغاء' : 'Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        deleteBloc.add(
                          DeleteEmployeeSubmitted(employeeId: employeeId),
                        );
                      },
                child: Text(isArabic ? 'حذف' : 'Delete'),
              ),
            ],
          );
        },
      );
    },
  ).then((_) {
    if (deleteBloc.state.status != DeleteEmployeeStatus.initial) {
      deleteBloc.add(const DeleteEmployeeReset());
    }
  });
}

class _PaginationFooter extends StatelessWidget {
  const _PaginationFooter({
    required this.state,
    required this.scheme,
    required this.isArabic,
  });

  final EmployeePageState state;
  final ColorScheme scheme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final pagination = state.pagination;
    final start =
        pagination?.from ??
        (state.currentPage - 1) * state.employeesPerPage + 1;
    final end = pagination?.to ?? (start + state.employees.length - 1);
    final total = pagination?.total ?? state.employees.length;

    return Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            isArabic
                ? 'عرض $start - $end من أصل $total موظف'
                : 'Showing $start - $end of $total employees',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              color: scheme.onSurface.withValues(alpha: 0.68),
              fontWeight: FontWeight.w600,
              fontSize: AppTypography.fs12,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PagerButton(
              label: isArabic ? 'السابق' : 'Prev',
              icon: Icons.chevron_left_rounded,
              enabled: state.hasPreviousPage,
              onPressed: state.hasPreviousPage
                  ? () => context.read<EmployeePageBloc>().add(
                      EmployeePageFetchRequested(
                        departmentId: state.departmentId,
                        page: state.currentPage - 1,
                        employeesPerPage: state.employeesPerPage,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            _PagerButton(
              label: isArabic ? 'التالي' : 'Next',
              icon: Icons.chevron_right_rounded,
              filled: true,
              enabled: state.hasNextPage,
              onPressed: state.hasNextPage
                  ? () => context.read<EmployeePageBloc>().add(
                      EmployeePageFetchRequested(
                        departmentId: state.departmentId,
                        page: state.currentPage + 1,
                        employeesPerPage: state.employeesPerPage,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}

class _PagerButton extends StatelessWidget {
  const _PagerButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onPressed,
    this.filled = false,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback? onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final background = filled ? scheme.primary : scheme.surface;
    final foreground = filled ? scheme.onPrimary : scheme.onSurface;

    return OutlinedButton.icon(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon, size: 18),
      label: Text(label),

      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          enabled ? background : scheme.surface.withValues(alpha: 0.5),
        ),

        foregroundColor: WidgetStatePropertyAll(
          enabled ? foreground : scheme.onSurface.withValues(alpha: 0.3),
        ),

        iconColor: WidgetStatePropertyAll(
          enabled ? foreground : scheme.onSurface.withValues(alpha: 0.3),
        ),

        overlayColor: WidgetStatePropertyAll(
          enabled ? foreground.withValues(alpha: 0.08) : Colors.transparent,
        ),

        side: WidgetStatePropertyAll(
          BorderSide(
            color: enabled
                ? scheme.primary.withValues(alpha: filled ? 0 : 0.18)
                : scheme.outline.withValues(alpha: 0.2),
          ),
        ),

        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),

        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
    );
  }
}

class _InlineFailureBanner extends StatelessWidget {
  const _InlineFailureBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: scheme.onErrorContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmployeeErrorState extends StatelessWidget {
  const _EmployeeErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: scheme.error.withValues(alpha: 0.15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 52, color: scheme.error),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? 'Retry'
                      : 'Retry',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
