import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_order_stages/order_stages_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_stages/order_stages_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_order_stages/order_stages_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_order_stages/order_stages_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderStagesRepository)
class OrderStagesRepositoryImpl
    implements OrderStagesRepository {

  const OrderStagesRepositoryImpl(
    this._remoteDataSource,
  );

  final OrderStagesRemoteDataSource
      _remoteDataSource;

  @override
  Future<Either<AppFailure, OrderStagesResponse>>
      getOrderStages() async {
    try {
      final response =
          await _remoteDataSource.getOrderStages();

      return Right(response);
    } catch (e) {
      return Left(AppErrorMapper.map(e));
    }
  }

  @override
  Future<Either<AppFailure, BaseResponseModel>>
      updateOrderStages({
    required OrderStagesEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.updateOrderStages(
        parameters: parameters,
      );

      return Right(response);
    } catch (e) {
      return Left(AppErrorMapper.map(e));
    }
  }
}