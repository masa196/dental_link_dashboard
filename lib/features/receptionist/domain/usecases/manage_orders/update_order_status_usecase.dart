import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/update_order_status_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/update_order_status_repository.dart';

@injectable
class UpdateOrderStatusUseCase
    extends BaseUseCase<BaseResponseModel, UpdateOrderStatusEntity> {
  UpdateOrderStatusUseCase(this.repository);

  final UpdateOrderStatusRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    UpdateOrderStatusEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
