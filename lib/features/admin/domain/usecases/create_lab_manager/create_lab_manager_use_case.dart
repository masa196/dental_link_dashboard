import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/create_lab_manager_repository.dart';

@injectable
class CreateLabManagerUseCase {
  const CreateLabManagerUseCase(this.repository);

  final CreateLabManagerRepository repository;

  Future<Either<AppFailure, BaseResponseModel>> call(
    CreateLabManagerEntity params,
  ) {
    return repository.call(params);
  }
}
