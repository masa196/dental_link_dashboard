import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_delivery/show_delivery_employees_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_employees_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/show_delivery_employees_repositrory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShowDeliveryEmployeesRepository)
class ShowDeliveryEmployeesRepositoryImpl
    implements ShowDeliveryEmployeesRepository {
  const ShowDeliveryEmployeesRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowDeliveryEmployeesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, DeliveryEmployeesResponse>> call({
    required ShowDeliveryEmployeesEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.getDeliveryEmployees(
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