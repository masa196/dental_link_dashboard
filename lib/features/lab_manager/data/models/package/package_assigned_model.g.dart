// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_assigned_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageAssignedResponse _$PackageAssignedResponseFromJson(
  Map<String, dynamic> json,
) => PackageAssignedResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PackageAssignedModel.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

PackageAssignedModel _$PackageAssignedModelFromJson(
  Map<String, dynamic> json,
) => PackageAssignedModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  durationDays: (json['duration_days'] as num?)?.toInt(),
  price: json['price'] as String?,
  isActive: json['is_active'] as bool?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);
