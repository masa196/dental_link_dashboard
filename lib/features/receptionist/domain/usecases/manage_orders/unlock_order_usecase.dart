import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/unlock_order_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class UnLockOrderUsecase
    extends BaseUseCase<BaseResponseModel, int > {
  UnLockOrderUsecase(this.repository);

  final UnLockOrderRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
     int orderId,
  ) {
    return repository.call(orderId: orderId);
  }
}
