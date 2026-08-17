import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/add_packages_entity.dart';



abstract interface class AddPackageRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required AddPackageEntity parameters,
  });
}


