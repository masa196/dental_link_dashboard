import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/edit_lab_manager/edit_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/edit_lab_manager_repository.dart';

@injectable
class EditLabManagerUseCase {
  const EditLabManagerUseCase(this.repository);

  final EditLabManagerRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(
    EditLabManagerEntity params,
  ) async {
    return repository(params);
  }
}
