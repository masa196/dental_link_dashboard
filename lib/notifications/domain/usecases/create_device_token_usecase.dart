import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';

import '../entities/device_token_entity.dart';
import '../repositories/notifications_repository.dart';


@injectable
class CreateDeviceTokenUseCase {

  CreateDeviceTokenUseCase(
    this.repository,
  );

  final NotificationsRepository repository;
  Future<Either<AppFailure, void>> call(
    DeviceTokenEntity entity,
  ) {
    return repository.createDeviceToken(entity);
  }
}