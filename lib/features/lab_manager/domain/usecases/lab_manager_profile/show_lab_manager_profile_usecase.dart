import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/lab_manager_profile/show_lab_manager_profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';

@injectable
class ShowLabManagerProfileUseCase
    extends BaseUseCase<LabManagerProfileResponse, NoParameters> {
  final ShowLabManagerProfileRepository repository;

  ShowLabManagerProfileUseCase(this.repository);

  @override
  Future<Either<AppFailure, LabManagerProfileResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
