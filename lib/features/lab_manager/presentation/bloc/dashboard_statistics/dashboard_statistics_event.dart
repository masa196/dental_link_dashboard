import 'package:equatable/equatable.dart';

abstract class DashboardStatisticsEvent extends Equatable {
  const DashboardStatisticsEvent();

  @override
  List<Object?> get props => [];
}

class GetDashboardStatisticsEvent extends DashboardStatisticsEvent {
  const GetDashboardStatisticsEvent();
}