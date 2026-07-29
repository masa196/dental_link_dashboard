import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/update_package_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_materials/update_package_repository.dart';

@injectable
class UpdatePackageUsecase
    extends BaseUseCase<BaseResponseModel, UpdatePackageEntity> {
  UpdatePackageUsecase(this.repository);

  final UpdatePackageRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    UpdatePackageEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
