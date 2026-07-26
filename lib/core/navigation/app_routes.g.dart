// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $loginRoute,
  $mainShellRoute,
  $labManagerShellRoute,
  $receptionistShellRoute,
];

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginRoute._fromState);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRoute => ShellRouteData.$route(
  factory: $MainShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/manage-labs',
      factory: $ManageLabsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'details/:labId',
          factory: $LabDetailsRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: '/profile', factory: $ProfileRoute._fromState),
    GoRouteData.$route(
      path: '/roles_management',
      factory: $RolesSystemManagementRoute._fromState,
    ),
  ],
);

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

mixin $ManageLabsRoute on GoRouteData {
  static ManageLabsRoute _fromState(GoRouterState state) =>
      const ManageLabsRoute();

  @override
  String get location => GoRouteData.$location('/manage-labs');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LabDetailsRoute on GoRouteData {
  static LabDetailsRoute _fromState(GoRouterState state) =>
      LabDetailsRoute(labId: state.pathParameters['labId']!);

  LabDetailsRoute get _self => this as LabDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage-labs/details/${Uri.encodeComponent(_self.labId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RolesSystemManagementRoute on GoRouteData {
  static RolesSystemManagementRoute _fromState(GoRouterState state) =>
      const RolesSystemManagementRoute();

  @override
  String get location => GoRouteData.$location('/roles_management');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $labManagerShellRoute => ShellRouteData.$route(
  factory: $LabManagerShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/lab-manager',
      factory: $LabManagerDashboardRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/employees',
      factory: $LabManagerEmployeesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/employees/create',
      factory: $CreateEmployeeRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/employees/edit',
      factory: $EditEmployeeRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/employees/:departmentId',
      factory: $EmployeePageRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/orders',
      factory: $LabManagerOrdersRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/orders/:orderId',
      factory: $OrderDetailsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/materials',
      factory: $LabManagerMaterialsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/staff',
      factory: $LabManagerStaffRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/roles',
      factory: $RolesManagementRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/profile',
      factory: $LabManagerProfileRoute._fromState,
    ),
  ],
);

extension $LabManagerShellRouteExtension on LabManagerShellRoute {
  static LabManagerShellRoute _fromState(GoRouterState state) =>
      const LabManagerShellRoute();
}

mixin $LabManagerDashboardRoute on GoRouteData {
  static LabManagerDashboardRoute _fromState(GoRouterState state) =>
      const LabManagerDashboardRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LabManagerEmployeesRoute on GoRouteData {
  static LabManagerEmployeesRoute _fromState(GoRouterState state) =>
      const LabManagerEmployeesRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/employees');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateEmployeeRoute on GoRouteData {
  static CreateEmployeeRoute _fromState(GoRouterState state) =>
      CreateEmployeeRoute($extra: state.extra as CreateEmployeeRouteExtra?);

  CreateEmployeeRoute get _self => this as CreateEmployeeRoute;

  @override
  String get location => GoRouteData.$location('/lab-manager/employees/create');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $EditEmployeeRoute on GoRouteData {
  static EditEmployeeRoute _fromState(GoRouterState state) =>
      const EditEmployeeRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/employees/edit');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EmployeePageRoute on GoRouteData {
  static EmployeePageRoute _fromState(GoRouterState state) => EmployeePageRoute(
    departmentId: int.parse(state.pathParameters['departmentId']!),
    departmentName: state.uri.queryParameters['department-name'],
    $extra: state.extra as EmployeePageRouteExtra?,
  );

  EmployeePageRoute get _self => this as EmployeePageRoute;

  @override
  String get location => GoRouteData.$location(
    '/lab-manager/employees/${Uri.encodeComponent(_self.departmentId.toString())}',
    queryParams: {
      if (_self.departmentName != null) 'department-name': _self.departmentName,
    },
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $LabManagerOrdersRoute on GoRouteData {
  static LabManagerOrdersRoute _fromState(GoRouterState state) =>
      const LabManagerOrdersRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/orders');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrderDetailsRoute on GoRouteData {
  static OrderDetailsRoute _fromState(GoRouterState state) =>
      OrderDetailsRoute(orderId: int.parse(state.pathParameters['orderId']!));

  OrderDetailsRoute get _self => this as OrderDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/lab-manager/orders/${Uri.encodeComponent(_self.orderId.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LabManagerMaterialsRoute on GoRouteData {
  static LabManagerMaterialsRoute _fromState(GoRouterState state) =>
      const LabManagerMaterialsRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/materials');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LabManagerStaffRoute on GoRouteData {
  static LabManagerStaffRoute _fromState(GoRouterState state) =>
      const LabManagerStaffRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/staff');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RolesManagementRoute on GoRouteData {
  static RolesManagementRoute _fromState(GoRouterState state) =>
      const RolesManagementRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/roles');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LabManagerProfileRoute on GoRouteData {
  static LabManagerProfileRoute _fromState(GoRouterState state) =>
      const LabManagerProfileRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $receptionistShellRoute => ShellRouteData.$route(
  factory: $ReceptionistShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/receptionist',
      factory: $ReceptionistDashboardRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/receptionist/orders/:orderId',
      factory: $ReceptionistOrderDetailsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/receptionist/delivery-tasks',
      factory: $ReceptionistDeliveryTasksRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/receptionist/show-materials',
      factory: $ReceptionistShowMaterialsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/receptionist/billing',
      factory: $ReceptionistBillingRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/receptionist/inquiries',
      factory: $ReceptionistInquiriesRoute._fromState,
    ),
  ],
);

extension $ReceptionistShellRouteExtension on ReceptionistShellRoute {
  static ReceptionistShellRoute _fromState(GoRouterState state) =>
      const ReceptionistShellRoute();
}

mixin $ReceptionistDashboardRoute on GoRouteData {
  static ReceptionistDashboardRoute _fromState(GoRouterState state) =>
      const ReceptionistDashboardRoute();

  @override
  String get location => GoRouteData.$location('/receptionist');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReceptionistOrderDetailsRoute on GoRouteData {
  static ReceptionistOrderDetailsRoute _fromState(GoRouterState state) =>
      ReceptionistOrderDetailsRoute(
        orderId: int.parse(state.pathParameters['orderId']!),
      );

  ReceptionistOrderDetailsRoute get _self =>
      this as ReceptionistOrderDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/receptionist/orders/${Uri.encodeComponent(_self.orderId.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReceptionistDeliveryTasksRoute on GoRouteData {
  static ReceptionistDeliveryTasksRoute _fromState(GoRouterState state) =>
      const ReceptionistDeliveryTasksRoute();

  @override
  String get location => GoRouteData.$location('/receptionist/delivery-tasks');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReceptionistShowMaterialsRoute on GoRouteData {
  static ReceptionistShowMaterialsRoute _fromState(GoRouterState state) =>
      const ReceptionistShowMaterialsRoute();

  @override
  String get location => GoRouteData.$location('/receptionist/show-materials');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReceptionistBillingRoute on GoRouteData {
  static ReceptionistBillingRoute _fromState(GoRouterState state) =>
      const ReceptionistBillingRoute();

  @override
  String get location => GoRouteData.$location('/receptionist/billing');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReceptionistInquiriesRoute on GoRouteData {
  static ReceptionistInquiriesRoute _fromState(GoRouterState state) =>
      const ReceptionistInquiriesRoute();

  @override
  String get location => GoRouteData.$location('/receptionist/inquiries');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
