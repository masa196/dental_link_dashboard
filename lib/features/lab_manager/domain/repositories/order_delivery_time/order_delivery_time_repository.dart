import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/order_delivery_time_entity/order_delivery_time_entity.dart';

abstract interface class OrderDeliveryTimeRepository {
  Future<Either<AppFailure, OrderDeliveryTimeResponse>>
      getDeliverySettings();

  Future<Either<AppFailure, OrderDeliveryTimeResponse>>
      updateDeliverySettings({
    required OrderDeliveryTimeEntity parameters,
  });
}