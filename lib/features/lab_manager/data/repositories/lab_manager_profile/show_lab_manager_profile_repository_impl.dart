import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/lab_manager_profile/show_lab_manager_profile_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/lab_manager_profile/show_lab_manager_profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';





@Injectable(as: ShowLabManagerProfileRepository)
class ShowLabManagerProfileRepositoryImpl
    implements ShowLabManagerProfileRepository {
  const ShowLabManagerProfileRepositoryImpl(this.remoteDataSource);

  final ShowLabManagerProfileRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, LabManagerProfileResponse>> call() async {
    try {
      final response = await remoteDataSource.getLabManagerProfile();
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

