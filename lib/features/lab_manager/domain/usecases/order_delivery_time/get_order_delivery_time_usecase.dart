import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/order_delivery_time/order_delivery_time_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetOrderDeliveryTimeUseCase
    extends BaseUseCase<OrderDeliveryTimeResponse, NoParameters> {
  final OrderDeliveryTimeRepository repository;

  GetOrderDeliveryTimeUseCase(this.repository);

  @override
  Future<Either<AppFailure, OrderDeliveryTimeResponse>> call(
    NoParameters parameters,
  ) {
    return repository.getDeliverySettings();
  }
}
