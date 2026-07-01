import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/create_role_entity/create_role_entity.dart';


abstract interface class CreateRoleRepository {
  Future<Either<AppFailure, BaseResponseModel>> call(
    CreateRoleEntity params,
  );
}

