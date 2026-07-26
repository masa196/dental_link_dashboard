import 'package:equatable/equatable.dart';

class ShowNotificationsEntity extends Equatable {
  const ShowNotificationsEntity({
    required this.notifications,
  });

  final List<NotificationEntity> notifications;

  @override
  List<Object?> get props => [notifications];
}

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.type,
    required this.notifiableId,
    required this.notifiableType,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String type;
  final int notifiableId;
  final String notifiableType;
  final NotificationDataEntity data;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        type,
        notifiableId,
        notifiableType,
        data,
        createdAt,
        updatedAt,
      ];
}

class NotificationDataEntity extends Equatable {
  const NotificationDataEntity({
    required this.orderId,
    required this.patientName,
    required this.serialNumber,
    required this.labId,
    required this.priority,
    required this.message,
  });

  final int orderId;
  final String patientName;
  final String serialNumber;
  final int labId;
  final String priority;
  final String message;

  @override
  List<Object?> get props => [
        orderId,
        patientName,
        serialNumber,
        labId,
        priority,
        message,
      ];
}