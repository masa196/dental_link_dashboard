import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_orders/show_orders_entity.dart';



abstract interface class ShowOrdersRepository {
  Future<Either<AppFailure, AllOrdersResponse>> call({
    required ShowOrdersEntity parameters,
  });
}
