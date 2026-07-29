import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctor_details_entity.dart';


abstract interface class ShowDoctorDetailsRepository {

  Future<Either<AppFailure, DoctorDetailsResponse>> call({

    required ShowDoctorDetailsEntity parameters,

  });

}