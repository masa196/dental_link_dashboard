import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/update_order_status_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/update_order_status_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/update_order_status_repository.dart';

@Injectable(as: UpdateOrderStatusRepository)
class UpdateOrderStatusRepositoryImpl
    implements UpdateOrderStatusRepository {
  const UpdateOrderStatusRepositoryImpl(
    this.remoteDataSource,
  );

  final UpdateOrderStatusRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required UpdateOrderStatusEntity parameters,
  }) async {
    try {
      final response = await remoteDataSource.updateStatus(parameters);

      return Right(response);
    } catch (error, stackTrace) {
      try {
        log(
          'UpdateOrderStatusRepositoryImpl caught error: ${error.runtimeType}',
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