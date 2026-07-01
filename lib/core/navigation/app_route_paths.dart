abstract final class AppRoutePaths {
  static const String labManagerEmployees = '/lab-manager/employees';
  static const String labManagerEmployeeCreate =
      '/lab-manager/employees/create';
  static String labManagerEmployeeDepartment(int departmentId) =>
      '/lab-manager/employees/$departmentId';
    static const String editEmployee = '/edit-employee';
}
