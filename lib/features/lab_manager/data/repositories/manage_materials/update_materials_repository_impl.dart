import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_materials/update_materials/update_materials_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/update_material_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/update_materials_repository.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: UpdateMaterialsRepository)
class UpdateMaterialsRepositoryImpl
    implements UpdateMaterialsRepository {
  const UpdateMaterialsRepositoryImpl(
    this._remoteDataSource,
  );

  final UpdateMaterialsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
  
    required UpdateMaterialEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.updateMaterials(
        parameters: parameters,
      );

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}