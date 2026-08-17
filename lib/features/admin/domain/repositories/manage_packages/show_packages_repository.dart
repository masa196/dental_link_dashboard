import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/show_package_entity.dart';



abstract interface class ShowPackagesRepository {
  Future<Either<AppFailure, PackagesResponse>> call({
    required ShowPackagesEntity parameters,
  });
}


