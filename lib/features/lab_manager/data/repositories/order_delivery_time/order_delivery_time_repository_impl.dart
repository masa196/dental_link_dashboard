import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/order_delivery_time/order_delivery_time_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/order_delivery_time_entity/order_delivery_time_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/order_delivery_time/order_delivery_time_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDeliveryTimeRepository)
class OrderDeliveryTimeRepositoryImpl
    implements OrderDeliveryTimeRepository {
  const OrderDeliveryTimeRepositoryImpl(
    this._remoteDataSource,
  );

  final OrderDelivreyTimeRemoteDataSource
      _remoteDataSource;

  @override
  Future<Either<AppFailure, OrderDeliveryTimeResponse>>
      getDeliverySettings() async {
    try {
      final response =
          await _remoteDataSource.getDeliverySettings();

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }

  @override
  Future<Either<AppFailure, OrderDeliveryTimeResponse>>
      updateDeliverySettings({
    required OrderDeliveryTimeEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.updateDeliverySettings(
        parameters: parameters,
      );

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}