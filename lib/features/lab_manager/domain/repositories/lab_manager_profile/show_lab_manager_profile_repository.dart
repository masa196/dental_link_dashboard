import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';

abstract interface class ShowLabManagerProfileRepository {
  Future<Either<AppFailure, LabManagerProfileResponse>> call();
}

