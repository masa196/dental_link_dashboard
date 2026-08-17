// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabStatisticsResponse _$LabStatisticsResponseFromJson(
  Map<String, dynamic> json,
) => LabStatisticsResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : LabStatistics.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

LabStatistics _$LabStatisticsFromJson(Map<String, dynamic> json) =>
    LabStatistics(
      activeLabsCount: (json['active_labs_count'] as num?)?.toInt(),
      inactiveLabsCount: (json['inactive_labs_count'] as num?)?.toInt(),
      totalLabsCount: (json['total_labs_count'] as num?)?.toInt(),
    );
