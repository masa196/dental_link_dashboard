import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/delete_materials_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';


@injectable
class DeleteMaterialsUseCase {
  const DeleteMaterialsUseCase(this.repository);
  final DeleteMaterialsRepository repository;
  Future<Either<AppFailure, BaseResponseModel>> call(int materialId) {
    return repository.call(materialId);
  }
}
