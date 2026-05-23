// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments_with_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentsWithEmployeeResponse _$DepartmentsWithEmployeeResponseFromJson(
  Map<String, dynamic> json,
) => DepartmentsWithEmployeeResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DepartmentCollection.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

DepartmentCollection _$DepartmentCollectionFromJson(
  Map<String, dynamic> json,
) => DepartmentCollection(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DepartmentItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

DepartmentItem _$DepartmentItemFromJson(Map<String, dynamic> json) =>
    DepartmentItem(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      employees: json['employees'] == null
          ? null
          : Employees.fromJson(json['employees'] as Map<String, dynamic>),
    );

Employees _$EmployeesFromJson(Map<String, dynamic> json) => Employees(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => EmployeesDatum.fromJson(e as Map<String, dynamic>))
      .toList(),
);

EmployeesDatum _$EmployeesDatumFromJson(Map<String, dynamic> json) =>
    EmployeesDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profile_image'] as String?,
      role: json['role'] == null
          ? null
          : EmployeeRole.fromJson(json['role'] as Map<String, dynamic>),
    );

EmployeeRole _$EmployeeRoleFromJson(Map<String, dynamic> json) => EmployeeRole(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);
