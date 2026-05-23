import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/login/login_response_model.dart';

import '../../entities/login_entity.dart';
import '../../repositories/login_repository.dart';

@injectable
class LoginUseCase {
  const LoginUseCase(this.repository);

  final LoginRepository repository;

  Future<Either<AppFailure, LoginResponseModel>> call(LoginEntity params) {
    return repository.call(params);
  }
}
