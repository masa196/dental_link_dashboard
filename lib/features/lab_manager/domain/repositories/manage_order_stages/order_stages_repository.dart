import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_stages/order_stages_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_order_stages/order_stages_entity.dart';

abstract interface class OrderStagesRepository {
  Future<Either<AppFailure, OrderStagesResponse>>
      getOrderStages();

  Future<Either<AppFailure, BaseResponseModel>>
      updateOrderStages({
    required OrderStagesEntity parameters,
  });
}