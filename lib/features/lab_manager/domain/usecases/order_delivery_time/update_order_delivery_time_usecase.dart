import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/order_delivery_time_entity/order_delivery_time_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/order_delivery_time/order_delivery_time_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderDeliveryTimeUsecase
    extends BaseUseCase<
        OrderDeliveryTimeResponse,
        OrderDeliveryTimeEntity> {
  UpdateOrderDeliveryTimeUsecase(
    this.repository,
  );

  final OrderDeliveryTimeRepository repository;

  @override
  Future<Either<AppFailure, OrderDeliveryTimeResponse>>
      call(
    OrderDeliveryTimeEntity parameters,
  ) {
    return repository.updateDeliverySettings(
      parameters: parameters,
    );
  }
}