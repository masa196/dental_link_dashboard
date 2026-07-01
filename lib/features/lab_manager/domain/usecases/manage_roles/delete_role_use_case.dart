import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/delete_role_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';


@injectable
class DeleteRoleUseCase {
  const DeleteRoleUseCase(this.repository);

  final DeleteRoleRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(int roleId) {
    return repository.call(roleId);
  }
}
