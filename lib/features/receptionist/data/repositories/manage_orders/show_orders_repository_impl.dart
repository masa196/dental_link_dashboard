import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/show_orders_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/show_orders_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/show_orders_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShowOrdersRepository)
class ShowOrdersRepositoryImpl
    implements ShowOrdersRepository {
  const ShowOrdersRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowOrdersRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, AllOrdersResponse>> call({
    required ShowOrdersEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.getOrders(
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