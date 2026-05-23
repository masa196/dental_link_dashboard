import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_employee_model.g.dart';

@JsonSerializable(createToJson: false)
class ShowEmployeeResponse extends Equatable {
  const  ShowEmployeeResponse({
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

    factory ShowEmployeeResponse.fromJson(Map<String, dynamic> json) => _$ShowEmployeeResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class DepartmentCollection  extends Equatable {
    const DepartmentCollection({
        required this.department,
    });

    final DepartmentItem? department;

    factory DepartmentCollection.fromJson(Map<String, dynamic> json) => _$DepartmentCollectionFromJson(json);

    @override
    List<Object?> get props => [
    department, ];
}

@JsonSerializable(createToJson: false)
class DepartmentItem extends Equatable {
    const DepartmentItem({
        required this.id,
        required this.labId,
        required this.name,
        required this.description,
        required this.isManagement,
        required this.employees,
        required this.createdAt,
    });

    final int? id;

    @JsonKey(name: 'lab_id') 
    final int? labId;
    final String? name;
    final dynamic description;

    @JsonKey(name: 'is_management') 
    final int? isManagement;
    
    final Employees? employees;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    factory DepartmentItem.fromJson(Map<String, dynamic> json) => _$DepartmentItemFromJson(json);

    @override
    List<Object?> get props => [
    id, labId, name, description, isManagement , employees, createdAt, ];
}

@JsonSerializable(createToJson: false)
class Employees extends Equatable {
    const Employees({
        required this.data,
        required this.links,
        required this.meta,
    });

    final List<EmployeesDatum>? data;
    final Links? links;
    final Meta? meta;

    factory Employees.fromJson(Map<String, dynamic> json) => _$EmployeesFromJson(json);

    @override
    List<Object?> get props => [
    data, links, meta, ];
}

@JsonSerializable(createToJson: false)
class EmployeesDatum extends Equatable {
    const EmployeesDatum({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.profileImage,
        required this.birthdate,
        required this.joinedAt,
        required this.role,
    });

    final int? id;
    final String? name;
    final String? email;
    final String? phone;

    @JsonKey(name: 'profile_image') 
    final String? profileImage;
    final DateTime? birthdate;

    @JsonKey(name: 'joined_at') 
    final DateTime? joinedAt;
    final Role? role;

    factory EmployeesDatum.fromJson(Map<String, dynamic> json) => _$EmployeesDatumFromJson(json);

    @override
    List<Object?> get props => [
    id, name, email, phone, profileImage, birthdate, joinedAt, role, ];
}

@JsonSerializable(createToJson: false)
class Role extends Equatable {
    const Role({
        required this.id,
        required this.name,
    });

    final int? id;
    final String? name;

    factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

    @override
    List<Object?> get props => [
    id, name, ];
}

@JsonSerializable(createToJson: false)
class Links extends Equatable {
   const  Links({
        required this.first,
        required this.last,
        required this.prev,
        required this.next,
    });

    final String? first;
    final String? last;
    final dynamic prev;
    final dynamic next;

    factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

    @override
    List<Object?> get props => [
    first, last, prev, next, ];
}

@JsonSerializable(createToJson: false)
class Meta extends Equatable {
   const  Meta({
        required this.currentPage,
        required this.from,
        required this.lastPage,
        required this.links,
        required this.path,
        required this.perPage,
        required this.to,
        required this.total,
    });

    @JsonKey(name: 'current_page') 
    final int? currentPage;
    final int? from;

    @JsonKey(name: 'last_page') 
    final int? lastPage;
    final List<Link>? links;
    final String? path;

    @JsonKey(name: 'per_page') 
    final int? perPage;
    final int? to;
    final int? total;

    factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

    @override
    List<Object?> get props => [
    currentPage, from, lastPage, links, path, perPage, to, total, ];
}

@JsonSerializable(createToJson: false)
class Link extends Equatable {
   const Link({
        required this.url,
        required this.label,
        required this.page,
        required this.active,
    });

    final String? url;
    final String? label;
    final int? page;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

    @override
    List<Object?> get props => [
    url, label, page, active, ];
}
