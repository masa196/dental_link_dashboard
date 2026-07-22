import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_delivery/show_delivery_tasks_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_tasks_model/delivery_tasks_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_tasks_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/show_delivery_tasks_repositrory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShowDeliveryTasksRepository)
class ShowDeliveryTasksRepositoryImpl
    implements ShowDeliveryTasksRepository {
  const ShowDeliveryTasksRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowDeliveryTasksRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, DeliveryTasksResponse>> call({
    required ShowDeliveryTasksEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.getDeliveryTasks(
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