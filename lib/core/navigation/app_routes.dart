import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_link_dashboard/core/extensions/page_builder_extension.dart';
import 'package:dental_link_dashboard/core/navigation/main_layout.dart';
import 'package:dental_link_dashboard/core/navigation/lab_manager_layout.dart';
import 'package:dental_link_dashboard/core/navigation/receptionist_layout.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/login_sceen.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/manage_labs_screen.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/profile/profile_screen.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_dashboard.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_dep/departments_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/employee_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard.dart';

part 'app_routes.g.dart';

final appRouterConfig = GoRouter(initialLocation: '/login', routes: $appRoutes);

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

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MainLayout(child: navigator);
  }
}

// --- 3. Manage Labs Route ---
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

// --- 4. Lab Details Route ---
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

// --- 5. Profile Route ---
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

/// ===== LAB MANAGER ROUTES =====
@TypedShellRoute<LabManagerShellRoute>(
  routes: [
    TypedGoRoute<LabManagerDashboardRoute>(path: '/lab-manager'),
    TypedGoRoute<LabManagerEmployeesRoute>(path: '/lab-manager/employees'),
    TypedGoRoute<EmployeePageRoute>(
      path: '/lab-manager/employees/:departmentId',
    ),
    TypedGoRoute<LabManagerTestsRoute>(path: '/lab-manager/tests'),
    TypedGoRoute<LabManagerPatientsRoute>(path: '/lab-manager/patients'),
    TypedGoRoute<LabManagerStaffRoute>(path: '/lab-manager/staff'),
    TypedGoRoute<LabManagerReportsRoute>(path: '/lab-manager/reports'),
  ],
)
class LabManagerShellRoute extends ShellRouteData {
  const LabManagerShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return LabManagerLayout(child: navigator);
  }
}

// --- Lab Manager Dashboard ---
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

// --- Lab Manager Employees ---
class LabManagerEmployeesRoute extends GoRouteData
    with $LabManagerEmployeesRoute {
  const LabManagerEmployeesRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return DepartmentsPage(
      onMenuTap: () => Scaffold.of(context).openDrawer(),
      showMenu: !Responsive.isDesktop(context),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Lab Manager Employee Page ---
class EmployeePageRoute extends GoRouteData with $EmployeePageRoute {
  const EmployeePageRoute({required this.departmentId, this.departmentName});

  final int departmentId;
  final String? departmentName;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return EmployeePage(
      departmentId: departmentId,
      departmentName: departmentName,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Lab Manager Tests ---
class LabManagerTestsRoute extends GoRouteData with $LabManagerTestsRoute {
  const LabManagerTestsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Lab Manager Tests Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Lab Manager Patients ---
class LabManagerPatientsRoute extends GoRouteData
    with $LabManagerPatientsRoute {
  const LabManagerPatientsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Lab Manager Patients Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Lab Manager Staff ---
class LabManagerStaffRoute extends GoRouteData with $LabManagerStaffRoute {
  const LabManagerStaffRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return DepartmentsPage(
      onMenuTap: () => Scaffold.of(context).openDrawer(),
      showMenu: !Responsive.isDesktop(context),
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Lab Manager Reports ---
class LabManagerReportsRoute extends GoRouteData with $LabManagerReportsRoute {
  const LabManagerReportsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      body: Center(child: Text('Lab Manager Reports Page')),
    ).buildPage(pageAnimation: PageAnimation.fade);
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
    return ReceptionistDashboard(
      onMenuTap: () => Scaffold.of(context).openDrawer(),
      showMenu: !Responsive.isDesktop(context),
    ).buildPage(pageAnimation: PageAnimation.fade);
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
