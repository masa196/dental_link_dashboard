import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_roles_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/roles/roles_model.dart';

@injectable
class GetRolesUseCase
    extends BaseUseCase<RolesResponse, NoParameters> {
  final GetRolesRepository repository;

  GetRolesUseCase(this.repository);

  @override
  Future<Either<AppFailure, RolesResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
