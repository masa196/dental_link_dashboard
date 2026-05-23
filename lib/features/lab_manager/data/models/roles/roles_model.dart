import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roles_model.g.dart';

@JsonSerializable(createToJson: false)
class RolesResponse extends Equatable {
   const RolesResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final Data? data;
    final dynamic errors;

    factory RolesResponse.fromJson(Map<String, dynamic> json) => _$RolesResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
    const Data({
        required this.roles,
    });

    final List<Role>? roles;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    roles, ];
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
