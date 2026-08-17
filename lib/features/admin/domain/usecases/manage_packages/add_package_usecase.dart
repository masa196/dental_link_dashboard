import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/add_packages_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_packages/add_package_repository.dart';

import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class AddPackageUsecase
    extends BaseUseCase<BaseResponseModel, AddPackageEntity> {
  AddPackageUsecase(this.repository);

  final AddPackageRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    AddPackageEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
