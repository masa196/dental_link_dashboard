import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/lab_statistics/lab_statistics_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/lab_statistics/lab_statistics_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetLabStatisticsUseCase
    extends BaseUseCase<LabStatisticsResponse, NoParameters> {
  final LabStatisticsRepository repository;

  GetLabStatisticsUseCase(this.repository);

  @override
  Future<Either<AppFailure, LabStatisticsResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
