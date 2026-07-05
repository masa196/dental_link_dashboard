import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/create_delivery_assignment_entity.dart';

abstract interface class CreateDeliveryAssignmentRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required CreateDeliveryAssignmentEntity parameters,
  });
}