import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/profile/change_password_entity.dart';



abstract interface class EditProfileRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required ChangePasswordEntity parameters,
  });
}


