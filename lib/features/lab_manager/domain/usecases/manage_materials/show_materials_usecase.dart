import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/show_materials_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/show_materials_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class ShowMaterialsUsecase
    extends BaseUseCase<ShowMaterialsResponse, ShowMaterialsEntity> {
  ShowMaterialsUsecase(this.repository);

  final ShowMaterialsRepository repository;

  @override
  Future<Either<AppFailure, ShowMaterialsResponse>> call(
    ShowMaterialsEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
