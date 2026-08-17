import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/datasources/assign_package_to_lab/assign_package_to_lab_remote_data_source.dart';
import 'package:dental_link_dashboard/features/admin/data/models/assign_package_to_lab/assign_package_to_lab_model.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import '../../../domain/entities/assign_package_to_lab/assign_package_to_lab_entity.dart';
import '../../../domain/repositories/assign_package_to_lab/assign_package_to_lab_repository.dart';

@Injectable(as: AssignPackageToLabRepository)
class AssignPackageToLabRepositoryImpl
    implements AssignPackageToLabRepository {
  AssignPackageToLabRepositoryImpl(
    this._remoteDataSource,
  );

  final AssignPackageToLabRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> assignPackageToLab(
    AssignPackageToLabEntity entity,
  ) async {
    try {
      final response = await _remoteDataSource.assignPackageToLab(
        entity.labId,
        AssignPackageToLabModel.fromEntity(entity),
      );

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}