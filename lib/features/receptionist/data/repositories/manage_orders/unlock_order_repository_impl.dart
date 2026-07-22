import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/unlock_order_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/update_order_status_remote_data_source.dart';


@Injectable(as: UnLockOrderRepository)
class UnLockOrderRepositoryImpl
    implements UnLockOrderRepository {
  const UnLockOrderRepositoryImpl(
    this.remoteDataSource,
  );

  final UpdateOrderStatusRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required int orderId,
  }) async {
    try {
      final response = await remoteDataSource.unLockOrder(orderId);

      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'UnLockOrderRepositoryImpl caught error: ${error.runtimeType}',
        );
        log(error.toString());
        log(stackTrace.toString());
      } catch (_) {}

      if (error is AppException) {
        return Left(
          AppErrorMapper.map(error),
        );
      }

      if (error is DioException) {
        return Left(
          AppErrorMapper.map(
            AppException.fromDioException(error),
          ),
        );
      }

      return const Left(
        AppFailure(
          type: AppFailureType.unexpected,
          message: 'Something went wrong',
        ),
      );
    }
  }
}