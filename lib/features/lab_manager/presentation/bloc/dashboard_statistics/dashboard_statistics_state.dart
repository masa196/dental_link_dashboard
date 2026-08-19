import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';

abstract class DashboardStatisticsState extends Equatable {
  const DashboardStatisticsState();

  @override
  List<Object?> get props => [];
}

class DashboardStatisticsInitial extends DashboardStatisticsState {
  const DashboardStatisticsInitial();
}

class DashboardStatisticsLoading extends DashboardStatisticsState {
  const DashboardStatisticsLoading();
}

class DashboardStatisticsSuccess extends DashboardStatisticsState {
  const DashboardStatisticsSuccess({
    required this.statistics,
  });

  final DashboardStatisticsResponse statistics;

  @override
  List<Object?> get props => [statistics];
}

class DashboardStatisticsFailure extends DashboardStatisticsState {
  const DashboardStatisticsFailure({
    required this.failure,
  });

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}