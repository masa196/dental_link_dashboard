import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';

import '../entities/show_notifications_entity.dart';
import '../repositories/notifications_repository.dart';

@injectable
class ShowNotificationsUseCase {
  const ShowNotificationsUseCase(
    this.repository,
  );

  final NotificationsRepository repository;

  Future<Either<AppFailure, ShowNotificationsEntity>> call() {
    return repository.showNotifications();
  }
}