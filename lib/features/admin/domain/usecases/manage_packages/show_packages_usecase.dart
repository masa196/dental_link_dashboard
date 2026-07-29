import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/show_package_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/manage_materials/show_packages_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class ShowPackagesUsecase
    extends BaseUseCase<PackagesResponse, ShowPackagesEntity> {
  ShowPackagesUsecase(this.repository);

  final ShowPackagesRepository repository;

  @override
  Future<Either<AppFailure, PackagesResponse>> call(
    ShowPackagesEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
