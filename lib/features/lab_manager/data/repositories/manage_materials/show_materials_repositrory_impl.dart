import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_materials/show_materials/show_materials_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/show_materials_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_materials/show_materials_repository.dart';


import 'package:injectable/injectable.dart';

@Injectable(as: ShowMaterialsRepository)
class ShowMaterialsRepositoryImpl
    implements ShowMaterialsRepository {
  const ShowMaterialsRepositoryImpl(
    this._remoteDataSource,
  );

  final ShowMaterialsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, ShowMaterialsResponse>> call({
    required ShowMaterialsEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.getMaterials(
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