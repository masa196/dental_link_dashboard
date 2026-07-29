import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_materials/delete_package_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';


@injectable
class DeletePackageUseCase {
  const DeletePackageUseCase(this.repository);
  final DeletePackageRepository repository;
  Future<Either<AppFailure, BaseResponseModel>> call(int packageId) {
    return repository.call(packageId);
  }
}
