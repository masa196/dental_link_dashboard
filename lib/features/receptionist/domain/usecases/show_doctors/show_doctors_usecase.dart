import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctors_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/show_doctors/show_doctors_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';

@injectable
class ShowDoctorsUsecase
    extends BaseUseCase<AllDoctorsResponse, ShowDoctorsEntity> {
  ShowDoctorsUsecase(this.repository);

  final ShowDoctorsRepository repository;

  @override
  Future<Either<AppFailure, AllDoctorsResponse>> call(
    ShowDoctorsEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
