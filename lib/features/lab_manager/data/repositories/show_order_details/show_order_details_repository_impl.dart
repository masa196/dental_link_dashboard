import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/show_order_details/show_order_details_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/show_order_details/show_order_details_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';


@Injectable(as: ShowOrderDetailsRepository)
class ShowOrderDetailsRepositoryImpl implements ShowOrderDetailsRepository {
  const ShowOrderDetailsRepositoryImpl(this.remoteDataSource);

  final ShowOrderDetailsRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, OrderDetailsResponse>> call(
      int orderId,
  ) async {
    try {
      final response = await remoteDataSource.showOrderDetails(orderId);
      return Right(response);
    } catch (error) {
      if (error is AppException) {
        return Left(AppErrorMapper.map(error));
      }

      if (error is DioException) {
        return Left(AppErrorMapper.map(AppException.fromDioException(error)));
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
