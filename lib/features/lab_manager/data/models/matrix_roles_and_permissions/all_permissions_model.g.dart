// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_permissions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPermissionsResponse _$AllPermissionsResponseFromJson(
  Map<String, dynamic> json,
) => AllPermissionsResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  permissions: (json['permissions'] as List<dynamic>?)
      ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);
