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
      path: '/lab-manager/employees/:departmentId',
      factory: $EmployeePageRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/tests',
      factory: $LabManagerTestsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/patients',
      factory: $LabManagerPatientsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/staff',
      factory: $LabManagerStaffRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lab-manager/reports',
      factory: $LabManagerReportsRoute._fromState,
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

mixin $EmployeePageRoute on GoRouteData {
  static EmployeePageRoute _fromState(GoRouterState state) => EmployeePageRoute(
    departmentId: int.parse(state.pathParameters['departmentId']!),
    departmentName: state.uri.queryParameters['department-name'],
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
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LabManagerTestsRoute on GoRouteData {
  static LabManagerTestsRoute _fromState(GoRouterState state) =>
      const LabManagerTestsRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/tests');

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

mixin $LabManagerPatientsRoute on GoRouteData {
  static LabManagerPatientsRoute _fromState(GoRouterState state) =>
      const LabManagerPatientsRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/patients');

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

mixin $LabManagerReportsRoute on GoRouteData {
  static LabManagerReportsRoute _fromState(GoRouterState state) =>
      const LabManagerReportsRoute();

  @override
  String get location => GoRouteData.$location('/lab-manager/reports');

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
      path: '/receptionist/appointments',
      factory: $ReceptionistAppointmentsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/receptionist/patients',
      factory: $ReceptionistPatientsRoute._fromState,
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

mixin $ReceptionistAppointmentsRoute on GoRouteData {
  static ReceptionistAppointmentsRoute _fromState(GoRouterState state) =>
      const ReceptionistAppointmentsRoute();

  @override
  String get location => GoRouteData.$location('/receptionist/appointments');

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

mixin $ReceptionistPatientsRoute on GoRouteData {
  static ReceptionistPatientsRoute _fromState(GoRouterState state) =>
      const ReceptionistPatientsRoute();

  @override
  String get location => GoRouteData.$location('/receptionist/patients');

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
