import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/update_order_status_entity.dart';



abstract interface class UpdateOrderStatusRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required UpdateOrderStatusEntity parameters,
  });
}
