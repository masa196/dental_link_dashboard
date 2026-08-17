import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/profile/change_password_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class ChangePasswordUsecase
    extends BaseUseCase<BaseResponseModel, ChangePasswordEntity> {
  ChangePasswordUsecase(this.repository);

  final EditProfileRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    ChangePasswordEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}


