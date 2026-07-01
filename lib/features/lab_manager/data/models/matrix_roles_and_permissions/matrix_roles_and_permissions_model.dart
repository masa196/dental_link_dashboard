import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matrix_roles_and_permissions_model.g.dart';

@JsonSerializable(createToJson: false)
class MatrixRolesResponse extends Equatable {
      const MatrixRolesResponse({
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

    factory MatrixRolesResponse.fromJson(Map<String, dynamic> json) => _$MatrixRolesResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
    const Data({
        required this.matrix,
    });

    final List<Matrix>? matrix;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    matrix, ];
}

@JsonSerializable(createToJson: false)
class Matrix extends Equatable {
    const Matrix({
        required this.id,
        required this.name,
        required this.permissions,
    });

    final int? id;
    final String? name;
    final List<String>? permissions;

    factory Matrix.fromJson(Map<String, dynamic> json) => _$MatrixFromJson(json);

    @override
    List<Object?> get props => [
    id, name, permissions, ];
}
