import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/location/location_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import '../../../domain/repositories/location/location_base_repository.dart';


@Injectable(as: LocationBaseRepository)
class LocationRepository extends LocationBaseRepository {
  final BaseLocationRemoteDataSource _baseAuthRemoteDataSource;

  LocationRepository(this._baseAuthRemoteDataSource);

  @override
  Future<Either<AppFailure, List<LocationModel>>> searchLocation(CreateLabManagerEntity data) async{
    try {
      final result = await _baseAuthRemoteDataSource.searchLocation(data);
      return Right(result);
    } on DioException catch (e) {
      final error = e.error;

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

  @override
  Future<Either<AppFailure, LocationModel>> reverseLocation(CreateLabManagerEntity data ) async{
    try {
      final result = await _baseAuthRemoteDataSource.reverseLocation(data);
      return Right(result);
    } on DioException catch (e) {
      final error = e.error;

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