import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/show_materials_entity.dart';


abstract interface class ShowMaterialsRepository {
  Future<Either<AppFailure, ShowMaterialsResponse>> call({
    required ShowMaterialsEntity parameters,
  });
}


