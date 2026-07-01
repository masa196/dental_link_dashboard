// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_roles_and_permissions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatrixRolesResponse _$MatrixRolesResponseFromJson(Map<String, dynamic> json) =>
    MatrixRolesResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  matrix: (json['matrix'] as List<dynamic>?)
      ?.map((e) => Matrix.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Matrix _$MatrixFromJson(Map<String, dynamic> json) => Matrix(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  permissions: (json['permissions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);
