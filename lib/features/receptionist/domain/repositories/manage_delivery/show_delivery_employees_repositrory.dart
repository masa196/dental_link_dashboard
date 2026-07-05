import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_employees_entity.dart';




abstract interface class ShowDeliveryEmployeesRepository {
  Future<Either<AppFailure, DeliveryEmployeesResponse>> call({
    required ShowDeliveryEmployeesEntity parameters,
  });
}
