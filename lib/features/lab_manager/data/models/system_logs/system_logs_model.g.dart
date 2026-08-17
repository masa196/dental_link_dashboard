// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_logs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemLogsResponse _$SystemLogsResponseFromJson(Map<String, dynamic> json) =>
    SystemLogsResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SystemLogItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
    );

SystemLogItem _$SystemLogItemFromJson(Map<String, dynamic> json) =>
    SystemLogItem(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] as String?,
      event: json['event'] as String?,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserInsSystemLogs.fromJson(json['user'] as Map<String, dynamic>),
      labId: (json['lab_id'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Metadata _$MetadataFromJson(Map<String, dynamic> json) =>
    Metadata(email: json['email'] as String?);

UserInsSystemLogs _$UserInsSystemLogsFromJson(Map<String, dynamic> json) =>
    UserInsSystemLogs(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );
