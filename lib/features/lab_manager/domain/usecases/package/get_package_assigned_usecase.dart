import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/package/package_assigned_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/package/package_assigned_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetPackageAssignedUseCase
    extends BaseUseCase<PackageAssignedResponse, NoParameters> {
  final PackageAssignedRepository repository;

  GetPackageAssignedUseCase(this.repository);

  @override
  Future<Either<AppFailure, PackageAssignedResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
