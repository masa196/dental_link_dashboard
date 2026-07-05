import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/show_orders_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/show_orders_repository.dart';

@injectable
class ShowOrdersUseCase
    extends BaseUseCase<AllOrdersResponse, ShowOrdersEntity> {
  ShowOrdersUseCase(this.repository);

  final ShowOrdersRepository repository;

  @override
  Future<Either<AppFailure, AllOrdersResponse>> call(
    ShowOrdersEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
