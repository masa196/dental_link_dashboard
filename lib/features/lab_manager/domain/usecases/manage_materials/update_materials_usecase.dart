import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/update_material_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/update_materials_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class UpdateMaterialsUsecase
    extends BaseUseCase<BaseResponseModel, UpdateMaterialEntity> {
  UpdateMaterialsUsecase(this.repository);

  final UpdateMaterialsRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    UpdateMaterialEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
