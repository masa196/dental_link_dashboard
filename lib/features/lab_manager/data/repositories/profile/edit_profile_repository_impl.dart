import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/profile/edit_profile_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/profile/change_password_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl
    implements EditProfileRepository {
  const EditProfileRepositoryImpl(
    this._remoteDataSource,
  );

  final EditProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
  
    required ChangePasswordEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.changePassword(
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