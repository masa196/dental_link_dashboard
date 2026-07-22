import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/add_material_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/add_materials_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class AddMaterialsUsecase
    extends BaseUseCase<BaseResponseModel, AddMaterialEntity> {
  AddMaterialsUsecase(this.repository);

  final AddMaterialsRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    AddMaterialEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
