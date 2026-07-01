import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/create_role_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/create_role_entity/create_role_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/create_role_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';



@LazySingleton(as: CreateRoleRepository)
class CreateRoleRepositoryImpl
    implements CreateRoleRepository {
  final CreateRoleRemoteDataSource remoteDataSource;

  const CreateRoleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    CreateRoleEntity params,
  ) async {
    try {
      final response = await remoteDataSource.createRole(params);

      return Right(BaseResponseModel.fromJson(response));
    } catch (error) {
      return Left(AppErrorMapper.map(error));
    }
  }
}