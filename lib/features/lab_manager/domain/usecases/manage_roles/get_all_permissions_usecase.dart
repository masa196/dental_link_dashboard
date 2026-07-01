import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/all_permissions_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_all_permissions_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetAllPermissionsUseCase
    extends BaseUseCase<AllPermissionsResponse, NoParameters> {
  final GetAllPermissionsRepository repository;

  GetAllPermissionsUseCase(this.repository);

  @override
  Future<Either<AppFailure, AllPermissionsResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
