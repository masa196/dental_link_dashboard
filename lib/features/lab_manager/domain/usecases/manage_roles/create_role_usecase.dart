import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/create_role_entity/create_role_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/create_role_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';



@injectable
class CreateRoleUseCase {
  const CreateRoleUseCase(this.repository);

  final CreateRoleRepository repository;
  Future<Either<AppFailure, BaseResponseModel>> call(CreateRoleEntity params) {
    return repository.call(params);
  }
}

