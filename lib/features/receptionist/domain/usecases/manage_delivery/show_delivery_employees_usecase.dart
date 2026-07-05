import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_employees_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/show_delivery_employees_repositrory.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class ShowDeliveryEmployeesUsecase
    extends BaseUseCase<DeliveryEmployeesResponse, ShowDeliveryEmployeesEntity> {
  ShowDeliveryEmployeesUsecase(this.repository);

  final ShowDeliveryEmployeesRepository repository;

  @override
  Future<Either<AppFailure, DeliveryEmployeesResponse>> call(
    ShowDeliveryEmployeesEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
