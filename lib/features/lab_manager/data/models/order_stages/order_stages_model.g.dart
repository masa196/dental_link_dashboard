// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_stages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStagesResponse _$OrderStagesResponseFromJson(Map<String, dynamic> json) =>
    OrderStagesResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : OrderStagesData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
    );

OrderStagesData _$OrderStagesDataFromJson(Map<String, dynamic> json) =>
    OrderStagesData(
      labId: (json['lab_id'] as num?)?.toInt(),
      totalDepartments: (json['total_departments'] as num?)?.toInt(),
      totalEstimatedTimeHours: (json['total_estimated_time_hours'] as num?)
          ?.toInt(),
      departments: (json['departments'] as List<dynamic>?)
          ?.map((e) => OrderStageDepartment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OrderStageDepartment _$OrderStageDepartmentFromJson(
  Map<String, dynamic> json,
) => OrderStageDepartment(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  sortOrder: (json['sort_order'] as num?)?.toInt(),
  timeAllowedHours: (json['time_allowed_hours'] as num?)?.toInt(),
  inOrderWorkflow: json['in_order_workflow'] as bool?,
);
