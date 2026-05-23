// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowEmployeeResponse _$ShowEmployeeResponseFromJson(
  Map<String, dynamic> json,
) => ShowEmployeeResponse(
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
  department: json['department'] == null
      ? null
      : DepartmentItem.fromJson(json['department'] as Map<String, dynamic>),
);

DepartmentItem _$DepartmentItemFromJson(Map<String, dynamic> json) =>
    DepartmentItem(
      id: (json['id'] as num?)?.toInt(),
      labId: (json['lab_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'],
      isManagement: (json['is_management'] as num?)?.toInt(),
      employees: json['employees'] == null
          ? null
          : Employees.fromJson(json['employees'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Employees _$EmployeesFromJson(Map<String, dynamic> json) => Employees(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => EmployeesDatum.fromJson(e as Map<String, dynamic>))
      .toList(),
  links: json['links'] == null
      ? null
      : Links.fromJson(json['links'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

EmployeesDatum _$EmployeesDatumFromJson(Map<String, dynamic> json) =>
    EmployeesDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profile_image'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
    );

Role _$RoleFromJson(Map<String, dynamic> json) =>
    Role(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
  first: json['first'] as String?,
  last: json['last'] as String?,
  prev: json['prev'],
  next: json['next'],
);

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  currentPage: (json['current_page'] as num?)?.toInt(),
  from: (json['from'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
      .toList(),
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
  url: json['url'] as String?,
  label: json['label'] as String?,
  page: (json['page'] as num?)?.toInt(),
  active: json['active'] as bool?,
);
