
import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/package/package_assigned_model.dart';



abstract interface class PackageAssignedRepository {
  Future<Either<AppFailure, PackageAssignedResponse>> call();
}


