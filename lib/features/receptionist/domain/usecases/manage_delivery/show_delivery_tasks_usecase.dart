import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_tasks_model/delivery_tasks_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_tasks_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/show_delivery_tasks_repositrory.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class ShowDeliveryTasksUsecase
    extends BaseUseCase<DeliveryTasksResponse, ShowDeliveryTasksEntity> {
  ShowDeliveryTasksUsecase(this.repository);

  final ShowDeliveryTasksRepository repository;

  @override
  Future<Either<AppFailure, DeliveryTasksResponse>> call(
    ShowDeliveryTasksEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
