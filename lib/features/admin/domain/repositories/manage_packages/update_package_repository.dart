import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/update_package_entity.dart';



abstract interface class UpdatePackageRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required UpdatePackageEntity parameters,
  });
}


