import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/assign_package_to_lab/assign_package_to_lab_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/assign_package_to_lab/assign_package_to_lab_repository.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';

@injectable
class AssignPackageToLabUsecase
    extends BaseUseCase<
        BaseResponseModel,
        AssignPackageToLabEntity> {
  AssignPackageToLabUsecase(
    this.repository,
  );

  final AssignPackageToLabRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    AssignPackageToLabEntity parameters,
  ) {
    return repository.assignPackageToLab(parameters);
  }
}