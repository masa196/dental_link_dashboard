
import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';




abstract interface class DashboardStatisticsRepository {
  Future<Either<AppFailure, DashboardStatisticsResponse>> call();
}


