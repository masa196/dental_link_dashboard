import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/add_material_entity.dart';


abstract interface class AddMaterialsRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required AddMaterialEntity parameters,
  });
}


