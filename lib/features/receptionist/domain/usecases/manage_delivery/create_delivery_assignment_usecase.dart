import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/create_delivery_assignment_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/create_delivery_assignment_repository.dart';

@injectable
class CreateDeliveryAssignmentUsecase
extends BaseUseCase<
        BaseResponseModel,
        CreateDeliveryAssignmentEntity> {
  CreateDeliveryAssignmentUsecase(
    this.repository,
  );

  final CreateDeliveryAssignmentRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    CreateDeliveryAssignmentEntity parameters,
  ) {
    return repository(
      parameters: parameters,
    );
  }
}