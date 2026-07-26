// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowNotificationResponse _$ShowNotificationResponseFromJson(
  Map<String, dynamic> json,
) => ShowNotificationResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  errors: json['errors'],
);

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      notifiableId: (json['notifiable_id'] as num?)?.toInt(),
      notifiableType: json['notifiable_type'] as String?,
      data: json['data'] == null
          ? null
          : NotificationData.fromJson(json['data'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      orderId: (json['order_id'] as num?)?.toInt(),
      patientName: json['patient_name'] as String?,
      serialNumber: json['serial_number'] as String?,
      labId: (json['lab_id'] as num?)?.toInt(),
      priority: json['priority'] as String?,
      message: json['message'] as String?,
    );
