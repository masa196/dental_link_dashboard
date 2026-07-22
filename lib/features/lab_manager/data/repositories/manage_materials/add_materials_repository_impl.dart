import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_materials/add_materials/add_materials_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/add_material_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/add_materials_repository.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: AddMaterialsRepository)
class AddMaterialsRepositoryImpl
    implements AddMaterialsRepository {
  const AddMaterialsRepositoryImpl(
    this._remoteDataSource,
  );

  final AddMaterialsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required AddMaterialEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.addMaterials(
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