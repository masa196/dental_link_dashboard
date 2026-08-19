class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl =
      'http://127.0.0.1:8000/api';

  static const Map<String, String> fileHeaders = {
    'ngrok-skip-browser-warning': 'true',
  };

  static String resolveFileUrl(String url) {
    final fileUri = Uri.parse(url);
    final baseUri = Uri.parse(baseUrl);

    return fileUri
        .replace(scheme: baseUri.scheme, host: baseUri.host, port: baseUri.port)
        .toString();
  }

  static const String searchLocation =
      'https://nominatim.openstreetmap.org/search';
  static const String reverseLocation =
      'https://nominatim.openstreetmap.org/reverse';

  ///////////////////////////System Admin Endpoints///////////////////////////

  //Authentication
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';

  //Manage Labs
  static const String activeLabs = '/auth/labs';
  static const String inactiveLabs = '/auth/labs/inactive';
  static const String createLabs = '/admin/labs';
  static const String editLabs = '/admin/labs';
  static const String deleteLabs = '/admin/labs';
  static const String labStatistics = '/admin/labs/stats';

  //Manage Packages
  static const String packages = '/admin/packages';
  static String updatePackage(int packageId) {
    return '/admin/packages/$packageId';
  }

  static String deletePackage(int packageId) {
    return '/admin/packages/$packageId';
  }

  static String getPackageHistorySysAdmin(int labId) {
    return '/admin/labs/$labId/package/history';
  }

  static String assignPackageToLab(int labId) {
    return '/admin/labs/$labId/package';
  }

  ///////////////////////////////Lab Manager EndPoints///////////////////////////

  //Manage Departments and Employees
  static const String departmentsWithEmployees =
      '/auth/lab/departments/with-employees/list';
  static const String createDepartments = '/auth/lab/departments/bulk';
  static const String departments = '/auth/lab/departments';
  static const String employees = '/auth/lab/employees';

  static String departmentEmployees(int departmentId) {
    return '/auth/lab/departments/$departmentId/with-employees';
  }

  //Management Roles and Permissions
  static const String getRoles = '/auth/roles';
  static const String matrixRolesAndPermissions = '/auth/lab/roles/matrix';
  static const String allPermissions = '/auth/lab/permissions';
  static const String createRole = '/auth/lab/roles';
  static const String deleteRole = '/auth/lab/roles';

  //Manage Materials
  static const String materials = '/auth/lab/compensations';

  static String updateMaterials(int materialId) {
    return '/auth/lab/compensations/$materialId';
  }

  //Manage Lab Manager Profile
  static const String labManagerProfile = '/auth/me';

  //Manage Delivery Settings
  static const String deliverySettings = '/auth/lab/delivery-settings';

  //Manage Order Stages
  static const String orderStages = '/auth/lab/department-route';
  static const String updateOrderStages = '/auth/lab/orders/departments';

  //Manage Portfolio
  static String createPortfolio(int labId) {
    return '/auth/labs/$labId/portfolio';
  }

  static String updatePortfolio(int labId, int portfolioId) {
    return '/auth/labs/$labId/portfolio/$portfolioId';
  }

  //Strip Link

  static const String stripeLink = '/auth/lab/stripe/account-link';

  //System Logs
  static const String getSystemLogs = '/auth/system-logs';

  //profile
  //Change Password
  static const String changePassword = '/auth/change-password';

 static const String packageAssigned = '/auth/lab/package';
  static const String dashboardStatistics = '/dashboard'; 

  ////////////////////////////Receptionist EndPoints///////////////////////////

  //Doctors
  static const String showDoctors = '/auth/lab/doctors/balances';
  static const String showDoctorDetails = '/auth/lab/doctors/orders';

  //Manage Orders
  static const String orders = '/auth/orders';
  static String qrImage(int orderId) {
    return '/auth/orders/$orderId/qr-image';
  }

  static String orderDetails(int orderId) {
    return '/auth/orders/$orderId';
  }

  static String updateOrderStatus(int orderId) {
    return '/auth/orders/$orderId/status';
  }

  static String lockOrder(int orderId) {
    return '/auth/orders/$orderId/lock';
  }

  static String unLockOrder(int orderId) {
    return '/auth/orders/$orderId/unlock';
  }

  //Manage Delivery
  static const String showDeliveryEmployees = '/auth/orders/delivery-employees';
  static const String showDeliveryTasks = '/auth/orders/delivery-tasks';

  //notifications
  static const String createDeviceToken = '/auth/notifications/device-tokens';
  static const String showNotifications = '/auth/notifications';
}
