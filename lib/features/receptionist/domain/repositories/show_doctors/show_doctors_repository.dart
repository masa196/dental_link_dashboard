import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctors_entity.dart';

abstract interface class ShowDoctorsRepository {
  Future<Either<AppFailure, AllDoctorsResponse>> call({
    required ShowDoctorsEntity parameters,
  });
}


