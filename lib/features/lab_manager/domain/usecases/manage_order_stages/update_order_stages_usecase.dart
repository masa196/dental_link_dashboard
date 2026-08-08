import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_order_stages/order_stages_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_order_stages/order_stages_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderStagesUsecase
    extends BaseUseCase<
        BaseResponseModel,
        OrderStagesEntity> {
  UpdateOrderStagesUsecase(
    this.repository,
  );

  final OrderStagesRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>>
      call(
    OrderStagesEntity parameters,
  ) {
    return repository.updateOrderStages(
      parameters: parameters,
    );
  }
}