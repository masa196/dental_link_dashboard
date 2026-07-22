import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/show_order_details/show_order_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowOrderDetailsUseCase
    extends BaseUseCase<OrderDetailsResponse, int> {
  ShowOrderDetailsUseCase(this.repository);

  final ShowOrderDetailsRepository repository;

  @override
  Future<Either<AppFailure, OrderDetailsResponse>> call(
    int orderId,
  ) {
    return repository.call(orderId);
  }
}
