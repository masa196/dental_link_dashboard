import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/notifications/domain/entities/show_notifications_entity.dart';
import '../entities/device_token_entity.dart';


abstract interface class NotificationsRepository {

  Future<Either<AppFailure, void>> createDeviceToken(
    DeviceTokenEntity entity,
  );

  Future<Either<AppFailure, ShowNotificationsEntity>> showNotifications();
}

