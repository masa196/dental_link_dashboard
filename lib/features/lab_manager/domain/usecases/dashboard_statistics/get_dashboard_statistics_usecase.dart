import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/dashboard_statistics/dashboard_statistics_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetDashboardStatisticsUseCase
    extends BaseUseCase<DashboardStatisticsResponse, NoParameters> {
  final DashboardStatisticsRepository repository;

  GetDashboardStatisticsUseCase(this.repository);

  @override
  Future<Either<AppFailure, DashboardStatisticsResponse>> call(
    NoParameters parameters,
  ) {
    return repository.call();
  }
}
