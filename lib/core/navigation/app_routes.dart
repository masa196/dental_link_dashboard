import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/show_employee/employee_page_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/edit_employee/edit_employee_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_roles/roles_permissions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_link_dashboard/core/extensions/page_builder_extension.dart';
import 'package:dental_link_dashboard/core/navigation/main_layout.dart';
import 'package:dental_link_dashboard/core/navigation/lab_manager_layout.dart';
import 'package:dental_link_dashboard/core/navigation/receptionist_layout.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/login_sceen.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/manage_labs_screen.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/profile/profile_screen.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_dashboard.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/departments_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/employee_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/create_employee/create_employee_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/receptionist_dashboard.dart';

part 'app_routes.g.dart';

abstract class AppRouter {
  static final GoRouter config = GoRouter(
    initialLocation: '/login',
    routes: $appRoutes,
  );
}

// مفاتيح مستقرة وفريدة لشاشات الـ Shell لمنع تدمير الـ State الداخلي عند تغيير الأبعاد
final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _labManagerNavigatorKey =
    GlobalKey<NavigatorState>();

/// ===== الكائنات الإضافية (Extra) لنقل الـ Blocs النشطة للحفاظ على الكاش =====

class CreateEmployeeRouteExtra {
  const CreateEmployeeRouteExtra({
    required this.departmentsBloc,
    required this.rolesBloc,
  });

  final DepartmentsWithEmployeeBloc departmentsBloc;
  final RolesBloc rolesBloc;
}

class EditEmployeeRouteExtra {
  const EditEmployeeRouteExtra({
    required this.employee,
    required this.departmentsBloc,
    required this.rolesBloc,
    this.departmentName,
  });

  final EmployeeEntity employee;
  final DepartmentsWithEmployeeBloc departmentsBloc;
  final RolesBloc rolesBloc;
  final String? departmentName;
}

class EmployeePageRouteExtra {
  const EmployeePageRouteExtra({
    required this.departmentsBloc,
    required this.rolesBloc,
  });

  final DepartmentsWithEmployeeBloc departmentsBloc;
  final RolesBloc rolesBloc;
}

/// ===== AUTH ROUTES =====
@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const LoginScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

/// ===== MAIN SYSTEM SHELL =====
@TypedShellRoute<MainShellRoute>(
  routes: [
    TypedGoRoute<ManageLabsRoute>(
      path: '/manage-labs',
      routes: [TypedGoRoute<LabDetailsRoute>(path: 'details/:labId')],
    ),
    TypedGoRoute<ProfileRoute>(path: '/profile'),
  ],
)
class MainShellRoute extends ShellRouteData {
  const MainShellRoute();

  GlobalKey<NavigatorState> get navigatorKey => _mainNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MainLayout(
      key: state.pageKey,
      child: KeyedSubtree(
        key: ValueKey(state.matchedLocation),
        child: navigator,
      ),
    );
  }
}

class ManageLabsRoute extends GoRouteData with $ManageLabsRoute {
  const ManageLabsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return ManageLabsScreen(
      onMenuTap: () => Scaffold.of(context).openDrawer(),
      showMenu: !Responsive.isDesktop(context),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class LabDetailsRoute extends GoRouteData with $LabDetailsRoute {
  final String labId;
  const LabDetailsRoute({required this.labId});

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Lab ID: $labId')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return ProfileScreen(
      onMenuTap: () => Scaffold.of(context).openDrawer(),
      showMenu: !Responsive.isDesktop(context),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

/// ===== LAB MANAGER SHELL ROUTES =====
@TypedShellRoute<LabManagerShellRoute>(
  routes: [
    TypedGoRoute<LabManagerDashboardRoute>(path: '/lab-manager'),
    TypedGoRoute<LabManagerEmployeesRoute>(path: '/lab-manager/employees'),
    TypedGoRoute<CreateEmployeeRoute>(path: '/lab-manager/employees/create'),
    TypedGoRoute<EditEmployeeRoute>(path: '/lab-manager/employees/edit'),
    TypedGoRoute<EmployeePageRoute>(
      path: '/lab-manager/employees/:departmentId',
    ),
    TypedGoRoute<LabManagerTestsRoute>(path: '/lab-manager/tests'),
    TypedGoRoute<LabManagerPatientsRoute>(path: '/lab-manager/patients'),
    TypedGoRoute<LabManagerStaffRoute>(path: '/lab-manager/staff'),
    TypedGoRoute<RolesManagementRoute>(path: '/lab-manager/roles'),
  ],
)
class LabManagerShellRoute extends ShellRouteData {
  const LabManagerShellRoute();

  GlobalKey<NavigatorState> get navigatorKey => _labManagerNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return LabManagerLayout(
      key: state.pageKey,
      child: KeyedSubtree(
        key: ValueKey(state.matchedLocation),
        child: navigator,
      ),
    );
  }
}

class LabManagerDashboardRoute extends GoRouteData
    with $LabManagerDashboardRoute {
  const LabManagerDashboardRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const LabManagerDashboard().buildPage(
      pageAnimation: PageAnimation.fade,
    );
  }
}

class LabManagerEmployeesRoute extends GoRouteData
    with $LabManagerEmployeesRoute {
  const LabManagerEmployeesRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    // 🛡️ نقوم بلف صفحة الأقسام بالـ Blocs المشتركة لضمان وجود الكاش للأدوار والأقسام معاً
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              locator<DepartmentsWithEmployeeBloc>()
                ..add(const DepartmentsWithEmployeeFetchRequested()),
        ),
        BlocProvider(
          create: (context) =>
              locator<RolesBloc>()..add(const RolesFetchRequested()),
        ),
      ],
      child: DepartmentsPage(
        key: state.pageKey,
        onMenuTap: () => Scaffold.of(context).openDrawer(),
        showMenu: !Responsive.isDesktop(context),
      ),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class EditEmployeeRoute extends GoRouteData with $EditEmployeeRoute {
  const EditEmployeeRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    final extra = state.extra;
    final payload = extra is EditEmployeeRouteExtra ? extra : null;
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: payload != null
          ? MultiBlocProvider(
              providers: [
                BlocProvider.value(value: payload.departmentsBloc),
                BlocProvider.value(value: payload.rolesBloc),
              ],
              child: EditEmployeePage(
                employee: payload.employee,
                departmentName: payload.departmentName,
              ),
            )
          : const EditEmployeePage(
              employee: EmployeeEntity(
                id: 0,
                name: '',
                email: '',
                phone: '',
                password: '',
                passwordConfirmation: '',
                birthdate: '',
                joinedAt: '',
                roleId: 0,
                departmentIds: [],
              ),
            ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class CreateEmployeeRoute extends GoRouteData with $CreateEmployeeRoute {
  const CreateEmployeeRoute({this.$extra});
  final CreateEmployeeRouteExtra? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    // 🛡️ فحص الـ extra الممرر من صفحة الأقسام أولاً بأمان
    final extra = state.extra;
    final payload =
        $extra ?? (extra is CreateEmployeeRouteExtra ? extra : null);

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: payload != null
          ? MultiBlocProvider(
              providers: [
                // تمرير نفس النسخ التي تحمل البيانات مسبقاً من شاشة الأقسام
                BlocProvider.value(value: payload.departmentsBloc),
                BlocProvider.value(value: payload.rolesBloc),
              ],
              child: const CreateEmployeePage(),
            )
          : MultiBlocProvider(
              providers: [
                // خيار احتياطي أخير من الـ locator لتفادي الـ Crash إذا فتحت الرابط مباشرة
                BlocProvider.value(
                  value: locator<DepartmentsWithEmployeeBloc>(),
                ),
                BlocProvider.value(value: locator<RolesBloc>()),
              ],
              child: const CreateEmployeePage(),
            ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class EmployeePageRoute extends GoRouteData with $EmployeePageRoute {
  const EmployeePageRoute({
    required this.departmentId,
    this.departmentName,
    this.$extra,
  });

  final int departmentId;
  final String? departmentName;
  final EmployeePageRouteExtra? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    final payload = $extra;

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<EmployeePageBloc>(
              param1: departmentId,
              param2: departmentName ?? '',
            ),
          ),
          if (payload != null) ...[
            BlocProvider.value(value: payload.departmentsBloc),
            BlocProvider.value(value: payload.rolesBloc),
          ],
        ],
        child: EmployeePage(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

/// ===== بقية مسارات الـ Shell والمشرفين الخالية من المشاكل =====
class LabManagerTestsRoute extends GoRouteData with $LabManagerTestsRoute {
  const LabManagerTestsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Center(child: Text('Tests'));
}

class LabManagerPatientsRoute extends GoRouteData
    with $LabManagerPatientsRoute {
  const LabManagerPatientsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Center(child: Text('Patients'));
}

class LabManagerStaffRoute extends GoRouteData with $LabManagerStaffRoute {
  const LabManagerStaffRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Center(child: Text('Staff'));
}

class RolesManagementRoute extends GoRouteData with $RolesManagementRoute {
  const RolesManagementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RolesPermissionsPage();
  }
}

/// ===== RECEPTIONIST ROUTES =====
@TypedShellRoute<ReceptionistShellRoute>(
  routes: [
    TypedGoRoute<ReceptionistDashboardRoute>(path: '/receptionist'),
    TypedGoRoute<ReceptionistAppointmentsRoute>(
      path: '/receptionist/appointments',
    ),
    TypedGoRoute<ReceptionistPatientsRoute>(path: '/receptionist/patients'),
    TypedGoRoute<ReceptionistBillingRoute>(path: '/receptionist/billing'),
    TypedGoRoute<ReceptionistInquiriesRoute>(path: '/receptionist/inquiries'),
  ],
)
class ReceptionistShellRoute extends ShellRouteData {
  const ReceptionistShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ReceptionistLayout(child: navigator);
  }
}

// --- Receptionist Dashboard ---

class ReceptionistDashboardRoute extends GoRouteData
    with $ReceptionistDashboardRoute {
  const ReceptionistDashboardRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const ReceptionistDashboardPage().buildPage(
      pageAnimation: PageAnimation.fade,
    );
  }
}

// --- Receptionist Appointments ---
class ReceptionistAppointmentsRoute extends GoRouteData
    with $ReceptionistAppointmentsRoute {
  const ReceptionistAppointmentsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Receptionist Appointments Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Receptionist Patients ---
class ReceptionistPatientsRoute extends GoRouteData
    with $ReceptionistPatientsRoute {
  const ReceptionistPatientsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Receptionist Patients Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Receptionist Billing ---
class ReceptionistBillingRoute extends GoRouteData
    with $ReceptionistBillingRoute {
  const ReceptionistBillingRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Receptionist Billing Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Receptionist Inquiries ---
class ReceptionistInquiriesRoute extends GoRouteData
    with $ReceptionistInquiriesRoute {
  const ReceptionistInquiriesRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Receptionist Inquiries Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}
