import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/show_doctors/show_doctor_details_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctor_details_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/show_doctors/show_doctor_details_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';


@Injectable(as: ShowDoctorDetailsRepository)
class ShowDoctorDetailsRepositoryImpl implements ShowDoctorDetailsRepository {

  const ShowDoctorDetailsRepositoryImpl(

    this._remoteDataSource,

  );

  final ShowDoctorDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, DoctorDetailsResponse>> call({

    required ShowDoctorDetailsEntity parameters,

  }) async {

    try {

      final response = await _remoteDataSource.getDoctorDetails(parameters);

      return Right(response);

    } catch(e) {

      return Left(
        AppErrorMapper.map(e),
      );
    }
  }

}