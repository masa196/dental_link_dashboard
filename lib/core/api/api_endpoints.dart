class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static const String searchLocation =
      'https://nominatim.openstreetmap.org/search';
  static const String reverseLocation =
      'https://nominatim.openstreetmap.org/reverse';

  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String activeLabs = '/auth/labs';
  static const String inactiveLabs = '/auth/labs/inactive';
  static const String createLabs = '/admin/labs';
  static const String editLabs = '/admin/labs';
  static const String deleteLabs = '/admin/labs';
  static const String departmentsWithEmployees = '/auth/lab/departments/with-employees/list';
  static const String createDepartmentsBulk = '/auth/lab/departments/bulk';
  static const String departments = '/auth/lab/departments';
  static String departmentEmployees(int departmentId) {
    return '/auth/lab/departments/$departmentId/with-employees';
  }

  static const String getRoles = '/auth/roles';
}
