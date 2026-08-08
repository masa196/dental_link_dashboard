import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_stages/order_stages_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_order_stages/order_stages_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetOrderStagesUseCase
    extends BaseUseCase<OrderStagesResponse, NoParameters> {
  final OrderStagesRepository repository;

  GetOrderStagesUseCase(this.repository);

  @override
  Future<Either<AppFailure, OrderStagesResponse>> call(
    NoParameters parameters,
  ) {
    return repository.getOrderStages();
  }
}
