import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctor_details_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/show_doctors/show_doctor_details_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';

@injectable
class ShowDoctorDetailsUsecase extends BaseUseCase< DoctorDetailsResponse,ShowDoctorDetailsEntity> {

  ShowDoctorDetailsUsecase(
    this.repository,
  );

  final ShowDoctorDetailsRepository repository;

  @override
  Future<Either<AppFailure, DoctorDetailsResponse>> call(
    ShowDoctorDetailsEntity parameters,
  ) {
    return repository.call(
      parameters: parameters,
    );
  }
}