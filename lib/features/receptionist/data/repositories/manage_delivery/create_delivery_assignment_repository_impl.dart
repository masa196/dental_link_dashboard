import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_delivery/create_delivery_assignment_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/create_delivery_assignment_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/create_delivery_assignment_repository.dart';

@Injectable(
  as: CreateDeliveryAssignmentRepository,
)
class CreateDeliveryAssignmentRepositoryImpl
    implements CreateDeliveryAssignmentRepository {
  const CreateDeliveryAssignmentRepositoryImpl(
    this._remoteDataSource,
  );

  final CreateDeliveryAssignmentRemoteDataSource
      _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required CreateDeliveryAssignmentEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.createDeliveryAssignment(
        parameters,
      );

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}