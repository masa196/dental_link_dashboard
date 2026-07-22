import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_tasks_model/delivery_tasks_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_tasks_entity.dart';

abstract interface class ShowDeliveryTasksRepository {
  Future<Either<AppFailure, DeliveryTasksResponse>> call({
    required ShowDeliveryTasksEntity parameters,
  });
}
