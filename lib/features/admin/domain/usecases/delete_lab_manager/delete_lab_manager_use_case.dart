import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/delete_lab_manager/delete_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/delete_lab_manager_repository.dart';

@injectable
class DeleteLabManagerUseCase {
  const DeleteLabManagerUseCase(this.repository);

  final DeleteLabManagerRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(
    DeleteLabManagerEntity params,
  ) {
    return repository.call(params);
  }
}
