import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/show_doctors/show_doctors_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctors_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/show_doctors/show_doctors_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShowDoctorsRepository)
class ShowDoctorsRepositoryImpl
    implements ShowDoctorsRepository {
  const ShowDoctorsRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowDoctorsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, AllDoctorsResponse>> call({
    required ShowDoctorsEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.getDoctors(
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