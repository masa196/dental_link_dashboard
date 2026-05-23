import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';




abstract class LocationBaseRepository {
  Future<Either<AppFailure,List<LocationModel>>> searchLocation(CreateLabManagerEntity data);
  Future<Either<AppFailure,LocationModel>> reverseLocation(CreateLabManagerEntity data);
}