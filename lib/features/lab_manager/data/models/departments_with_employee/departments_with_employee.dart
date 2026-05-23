import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'departments_with_employee.g.dart';

@JsonSerializable(createToJson: false)
class DepartmentsWithEmployeeResponse extends Equatable {
  const DepartmentsWithEmployeeResponse({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final int? status;
  final String? message;
  final DepartmentCollection? data;
  final dynamic errors;

  factory DepartmentsWithEmployeeResponse.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsWithEmployeeResponseFromJson(json);

  @override
  List<Object?> get props => [success, status, message, data, errors];
}

@JsonSerializable(createToJson: false)
class DepartmentCollection extends Equatable {
  const DepartmentCollection({required this.data});

  final List<DepartmentItem>? data;

  factory DepartmentCollection.fromJson(Map<String, dynamic> json) =>
      _$DepartmentCollectionFromJson(json);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(createToJson: false)
class DepartmentItem extends Equatable {
  const DepartmentItem({
    required this.id,
    required this.name,
    required this.employees,
  });

  final int? id;
  final String? name;
  final Employees? employees;

  factory DepartmentItem.fromJson(Map<String, dynamic> json) =>
      _$DepartmentItemFromJson(json);

  @override
  List<Object?> get props => [id, name, employees];
}

@JsonSerializable(createToJson: false)
class Employees extends Equatable {
  const Employees({required this.data});

  final List<EmployeesDatum>? data;

  factory Employees.fromJson(Map<String, dynamic> json) =>
      _$EmployeesFromJson(json);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(createToJson: false)
class EmployeesDatum extends Equatable {
  const EmployeesDatum({
    required this.id,
    required this.name,
    required this.phone,
    required this.profileImage,
    required this.role,
  });

  final int? id;
  final String? name;
  final String? phone;

  @JsonKey(name: 'profile_image')
  final String? profileImage;
  final EmployeeRole? role;

  factory EmployeesDatum.fromJson(Map<String, dynamic> json) =>
      _$EmployeesDatumFromJson(json);

  @override
  List<Object?> get props => [id, name, phone, profileImage, role];
}

@JsonSerializable(createToJson: false)
class EmployeeRole extends Equatable {
  const EmployeeRole({required this.id, required this.name});

  final int? id;
  final String? name;

  factory EmployeeRole.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRoleFromJson(json);

  @override
  List<Object?> get props => [id, name];
}
