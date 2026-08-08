import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/packages_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/show_employee/employee_page_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/get_order_stages/get_order_stages_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_order_stages/update_order_stages/update_order_stages_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/lab_manager_profile_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_employee/edit_employee/edit_employee_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/materials_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_roles/roles_permissions_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/order_details_page.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/orders/lab_manager_order_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctor_details/doctor_details_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/receptionist_delivery_tasks_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/show_materials/show_materials_page.dart';
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
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/receptionist_dashboard_page.dart';

part 'app_routes.g.dart';

enum OrderDetailsSource { labManagerOrders, receptionistOrders, doctorDetails }

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
    TypedGoRoute<RolesSystemManagementRoute>(path: '/roles_management'),
    TypedGoRoute<PackagesSystemManagementRoute>(path: '/packages_management'),
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

class RolesSystemManagementRoute extends GoRouteData
    with $RolesSystemManagementRoute {
  const RolesSystemManagementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RolesPermissionsPage();
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

class PackagesSystemManagementRoute extends GoRouteData
    with $PackagesSystemManagementRoute {
  const PackagesSystemManagementRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    debugPrint("PackagesSystemManagementRoute.buildPage");

    return const PackagesPage().buildPage(pageAnimation: PageAnimation.fade);
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
    TypedGoRoute<LabManagerOrdersRoute>(path: '/lab-manager/orders'),
    TypedGoRoute<OrderDetailsRoute>(path: '/lab-manager/orders/:orderId'),
    TypedGoRoute<LabManagerMaterialsRoute>(path: '/lab-manager/materials'),
    TypedGoRoute<LabManagerStaffRoute>(path: '/lab-manager/staff'),
    TypedGoRoute<RolesManagementRoute>(path: '/lab-manager/roles'),
    TypedGoRoute<LabManagerShowDoctorsRoute>(path: '/lab-manager/doctors'),
    TypedGoRoute<LabManagerDoctorDetailsRoute>(
      path: '/lab-manager/doctors/:doctorId',
    ),
    TypedGoRoute<DoctorOrderDetailsRoute>(
      path: '/lab-manager/doctors/:doctorId/orders/:orderId',
    ),

    TypedGoRoute<LabManagerProfileRoute>(path: '/lab-manager/profile'),
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

class LabManagerShowDoctorsRoute extends GoRouteData
    with $LabManagerShowDoctorsRoute {
  const LabManagerShowDoctorsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const DoctorsPage(
      mode: DoctorsPageMode.labManager,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class LabManagerDoctorDetailsRoute extends GoRouteData
    with $LabManagerDoctorDetailsRoute {
  const LabManagerDoctorDetailsRoute({required this.doctorId});

  final int doctorId;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return DoctorDetailsPage(
      mode: DoctorsPageMode.labManager,
      doctorId: doctorId,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class DoctorOrderDetailsRoute extends GoRouteData
    with $DoctorOrderDetailsRoute {
  const DoctorOrderDetailsRoute({
    required this.doctorId,
    required this.orderId,
  });

  final int doctorId;
  final int orderId;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return OrderDetailsPage(
      orderId: orderId,
      source: OrderDetailsSource.doctorDetails,
    ).buildPage(
      pageAnimation: PageAnimation.fade,
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

        BlocProvider(create: (context) => locator<GetOrderStagesBloc>()),
        BlocProvider(create: (context) => locator<UpdateOrderStagesBloc>()),
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

class LabManagerOrdersRoute extends GoRouteData with $LabManagerOrdersRoute {
  const LabManagerOrdersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LabManagerOrdersPage();
  }
}

class OrderDetailsRoute extends GoRouteData with $OrderDetailsRoute {
  const OrderDetailsRoute({
    required this.orderId,
    this.source = OrderDetailsSource.labManagerOrders,
  });

  final int orderId;
  final OrderDetailsSource source;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return OrderDetailsPage(
      orderId: orderId,
      source: source,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class LabManagerMaterialsRoute extends GoRouteData
    with $LabManagerMaterialsRoute {
  const LabManagerMaterialsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    debugPrint("LabManagerMaterialsRoute.buildPage");

    return const MaterialsPage().buildPage(pageAnimation: PageAnimation.fade);
  }
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

class LabManagerProfileRoute extends GoRouteData with $LabManagerProfileRoute {
  const LabManagerProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LabManagerProfilePage();
  }
}

/// ===== RECEPTIONIST ROUTES =====
@TypedShellRoute<ReceptionistShellRoute>(
  routes: [
    TypedGoRoute<ReceptionistDashboardRoute>(path: '/receptionist'),
    TypedGoRoute<ReceptionistOrderDetailsRoute>(
      path: '/receptionist/orders/:orderId',
    ),

    TypedGoRoute<ReceptionistDeliveryTasksRoute>(
      path: '/receptionist/delivery-tasks',
    ),
    TypedGoRoute<ReceptionistShowMaterialsRoute>(
      path: '/receptionist/show-materials',
    ),
    TypedGoRoute<ReceptionistShowDoctorsRoute>(path: '/receptionist/doctors'),
    TypedGoRoute<ReceptionistDoctorDetailsRoute>(
      path: '/receptionist/doctors/:doctorId',
    ),
    TypedGoRoute<ReceptionistDoctorOrderDetailsRoute>(
  path: '/receptionist/doctors/:doctorId/orders/:orderId',
),
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

class ReceptionistOrderDetailsRoute extends GoRouteData
    with $ReceptionistOrderDetailsRoute {
  const ReceptionistOrderDetailsRoute({required this.orderId});

  final int orderId;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return OrderDetailsPage(
      orderId: orderId,
      source: OrderDetailsSource.receptionistOrders,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

// --- Receptionist Delivery Tasks ---
class ReceptionistDeliveryTasksRoute extends GoRouteData
    with $ReceptionistDeliveryTasksRoute {
  const ReceptionistDeliveryTasksRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const ReceptionistDeliveryTasksPage().buildPage(
      pageAnimation: PageAnimation.fade,
    );
  }
}

// --- Receptionist Show Materials ---
class ReceptionistShowMaterialsRoute extends GoRouteData
    with $ReceptionistShowMaterialsRoute {
  const ReceptionistShowMaterialsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const ShowMaterialsPage().buildPage(
      pageAnimation: PageAnimation.fade,
    );
  }
}

// --- Receptionist show Doctors ---
class ReceptionistShowDoctorsRoute extends GoRouteData
    with $ReceptionistShowDoctorsRoute {
  const ReceptionistShowDoctorsRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const DoctorsPage(
      mode: DoctorsPageMode.receptionist,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}

class ReceptionistDoctorDetailsRoute extends GoRouteData
    with $ReceptionistDoctorDetailsRoute {
  const ReceptionistDoctorDetailsRoute({required this.doctorId});

  final int doctorId;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return DoctorDetailsPage(
      mode: DoctorsPageMode.receptionist,
      doctorId: doctorId,
    ).buildPage(pageAnimation: PageAnimation.fade);
  }
}


class ReceptionistDoctorOrderDetailsRoute extends GoRouteData
    with $ReceptionistDoctorOrderDetailsRoute {
  const ReceptionistDoctorOrderDetailsRoute({
    required this.doctorId,
    required this.orderId,
  });

  final int doctorId;
  final int orderId;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return OrderDetailsPage(
      orderId: orderId,
      source: OrderDetailsSource.doctorDetails,
    ).buildPage(
      pageAnimation: PageAnimation.fade,
    );
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
