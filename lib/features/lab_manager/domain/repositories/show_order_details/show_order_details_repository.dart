import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';

abstract interface class ShowOrderDetailsRepository {
  Future<Either<AppFailure, OrderDetailsResponse>> call(int orderId);
}
