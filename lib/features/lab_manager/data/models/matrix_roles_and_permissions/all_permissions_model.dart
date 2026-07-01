import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_permissions_model.g.dart';

@JsonSerializable(createToJson: false)
class AllPermissionsResponse extends Equatable {
    const AllPermissionsResponse({
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

    factory AllPermissionsResponse.fromJson(Map<String, dynamic> json) => _$AllPermissionsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
    const Data({
        required this.permissions,
    });

    final List<Permission>? permissions;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    permissions, ];
}

@JsonSerializable(createToJson: false)
class Permission extends Equatable {
    const Permission({
        required this.id,
        required this.name,
    });

    final int? id;
    final String? name;

    factory Permission.fromJson(Map<String, dynamic> json) => _$PermissionFromJson(json);

    @override
    List<Object?> get props => [
    id, name, ];
}
