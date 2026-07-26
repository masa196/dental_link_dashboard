import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/notifications/domain/entities/show_notifications_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';

import '../../domain/entities/device_token_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';
import '../models/device_token_request_model.dart';


@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl
    implements NotificationsRepository {

  NotificationsRepositoryImpl(
    this.remoteDataSource,
  );


  final NotificationsRemoteDataSource remoteDataSource;


  @override
  Future<Either<AppFailure, void>> createDeviceToken(
    DeviceTokenEntity entity,
  ) async {

    try {

      await remoteDataSource.createDeviceToken(
        DeviceTokenRequestModel(
          token: entity.token,
          deviceType: entity.deviceType,
        ),
      );

      return const Right(null);

    } on AppException catch(error) {

    return Left(
        AppErrorMapper.map(error),
      );

    }
  }

  @override
Future<Either<AppFailure, ShowNotificationsEntity>>
    showNotifications() async {
  try {
    final response = await remoteDataSource.showNotifications();

    return Right(
      ShowNotificationsEntity(
        notifications: response.data
                ?.map(
                  (item) => NotificationEntity(
                    id: item.id ?? 0,
                    type: item.type ?? '',
                    notifiableId: item.notifiableId ?? 0,
                    notifiableType: item.notifiableType ?? '',
                    createdAt:
                        item.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
                    updatedAt:
                        item.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
                    data: NotificationDataEntity(
                      orderId: item.data?.orderId ?? 0,
                      patientName: item.data?.patientName ?? '',
                      serialNumber: item.data?.serialNumber ?? '',
                      labId: item.data?.labId ?? 0,
                      priority: item.data?.priority ?? '',
                      message: item.data?.message ?? '',
                    ),
                  ),
                )
                .toList() ??
            [],
      ),
    );
  } on AppException catch (error) {
    return Left(AppErrorMapper.map(error));
  }
}
}