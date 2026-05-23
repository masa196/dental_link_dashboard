// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolesResponse _$RolesResponseFromJson(Map<String, dynamic> json) =>
    RolesResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  roles: (json['roles'] as List<dynamic>?)
      ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Role _$RoleFromJson(Map<String, dynamic> json) =>
    Role(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);
