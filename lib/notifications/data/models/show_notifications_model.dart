import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_notifications_model.g.dart';

@JsonSerializable(createToJson: false)
class ShowNotificationResponse extends Equatable {
  const ShowNotificationResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final List<NotificationItem>? data;
    final dynamic errors;

    factory ShowNotificationResponse.fromJson(Map<String, dynamic> json) => _$ShowNotificationResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class NotificationItem extends Equatable {
    const NotificationItem({
        required this.id,
        required this.type,
        required this.notifiableId,
        required this.notifiableType,
        required this.data,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? type;

    @JsonKey(name: 'notifiable_id') 
    final int? notifiableId;

    @JsonKey(name: 'notifiable_type') 
    final String? notifiableType;
    final NotificationData? data;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    factory NotificationItem.fromJson(Map<String, dynamic> json) => _$NotificationItemFromJson(json);

    @override
    List<Object?> get props => [
    id, type, notifiableId, notifiableType, data, createdAt, updatedAt, ];
}

@JsonSerializable(createToJson: false)
class NotificationData extends Equatable {
    const NotificationData({
        required this.orderId,
        required this.patientName,
        required this.serialNumber,
        required this.labId,
        required this.priority,
        required this.message,
    });

    @JsonKey(name: 'order_id') 
    final int? orderId;

    @JsonKey(name: 'patient_name') 
    final String? patientName;

    @JsonKey(name: 'serial_number') 
    final String? serialNumber;

    @JsonKey(name: 'lab_id') 
    final int? labId;
    final String? priority;
    final String? message;

    factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

    @override
    List<Object?> get props => [
    orderId, patientName, serialNumber, labId, priority, message, ];
}
