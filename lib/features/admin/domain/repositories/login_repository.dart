import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/login_entity.dart';

import 'package:dental_link_dashboard/features/admin/data/models/login/login_response_model.dart';

abstract interface class LoginRepository {
  Future<Either<AppFailure, LoginResponseModel>> call(LoginEntity params);
}
