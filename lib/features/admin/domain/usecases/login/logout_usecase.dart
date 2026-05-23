import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/logout/logout_response_model.dart';

import '../../repositories/logout_repository.dart';

@injectable
class LogoutUseCase {
  const LogoutUseCase(this.repository);

  final LogoutRepository repository;

  Future<Either<AppFailure, LogoutResponseModel>> call(String token) {
    return repository.call(token);
  }
}
