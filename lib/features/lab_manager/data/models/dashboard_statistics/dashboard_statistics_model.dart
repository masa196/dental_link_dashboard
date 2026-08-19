import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_statistics_model.g.dart';

@JsonSerializable(createToJson: false)
class DashboardStatisticsResponse extends Equatable {
  const DashboardStatisticsResponse({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final int? status;
  final String? message;
  final DashboardStatisticsData? data;
  final dynamic errors;

  factory DashboardStatisticsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DashboardStatisticsResponseFromJson(json);

  @override
  List<Object?> get props => [
        success,
        status,
        message,
        data,
        errors,
      ];
}

@JsonSerializable(createToJson: false)
class DashboardStatisticsData extends Equatable {
  const DashboardStatisticsData({
    required this.averageDeliveryTime,
    required this.monthlyRevenue,
    required this.technicianProductivity,
    required this.departmentWorkload,
    required this.topClinics,
    required this.yearlyPerformanceChart,
    required this.dateRange,
  });

  @JsonKey(name: 'average_delivery_time')
  final AverageDeliveryTimeStatistics? averageDeliveryTime;

  @JsonKey(name: 'monthly_revenue')
  final MonthlyRevenueStatistics? monthlyRevenue;

  @JsonKey(name: 'technician_productivity')
  final TechnicianProductivityStatistics? technicianProductivity;

  @JsonKey(name: 'department_workload')
  final DepartmentWorkloadStatistics? departmentWorkload;

  @JsonKey(name: 'top_clinics')
  final TopClinicsStatistics? topClinics;

  @JsonKey(name: 'yearly_performance_chart')
  final YearlyPerformanceStatistics? yearlyPerformanceChart;

  @JsonKey(name: 'date_range')
  final StatisticsDateRange? dateRange;

  factory DashboardStatisticsData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DashboardStatisticsDataFromJson(json);

  @override
  List<Object?> get props => [
        averageDeliveryTime,
        monthlyRevenue,
        technicianProductivity,
        departmentWorkload,
        topClinics,
        yearlyPerformanceChart,
        dateRange,
      ];
}

@JsonSerializable(createToJson: false)
class AverageDeliveryTimeStatistics extends Equatable {
  const AverageDeliveryTimeStatistics({
    required this.averageDays,
  });

  @JsonKey(name: 'average_days')
  final double? averageDays;

  factory AverageDeliveryTimeStatistics.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AverageDeliveryTimeStatisticsFromJson(json);

  @override
  List<Object?> get props => [
        averageDays,
      ];
}

@JsonSerializable(createToJson: false)
class StatisticsDateRange extends Equatable {
  StatisticsDateRange({
    required this.from,
    required this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory StatisticsDateRange.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$StatisticsDateRangeFromJson(json);

  @override
  List<Object?> get props => [
        from,
        to,
      ];
}

@JsonSerializable(createToJson: false)
class DepartmentWorkloadStatistics extends Equatable {
  DepartmentWorkloadStatistics({
    required this.departments,
  });

  final List<DepartmentWorkloadItem>? departments;

  factory DepartmentWorkloadStatistics.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DepartmentWorkloadStatisticsFromJson(json);

  @override
  List<Object?> get props => [
        departments,
      ];
}

@JsonSerializable(createToJson: false)
class DepartmentWorkloadItem extends Equatable {
  const DepartmentWorkloadItem({
    required this.departmentId,
    required this.name,
    required this.inProgressTasks,
  });

  @JsonKey(name: 'department_id')
  final int? departmentId;

  final String? name;

  @JsonKey(name: 'in_progress_tasks')
  final int? inProgressTasks;

  factory DepartmentWorkloadItem.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DepartmentWorkloadItemFromJson(json);

  @override
  List<Object?> get props => [
        departmentId,
        name,
        inProgressTasks,
      ];
}

@JsonSerializable(createToJson: false)
class MonthlyRevenueStatistics extends Equatable {
  const MonthlyRevenueStatistics({
    required this.totalRevenue,
    required this.ordersCount,
  });

  @JsonKey(name: 'total_revenue')
  final int? totalRevenue;

  @JsonKey(name: 'orders_count')
  final int? ordersCount;

  factory MonthlyRevenueStatistics.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MonthlyRevenueStatisticsFromJson(json);

  @override
  List<Object?> get props => [
        totalRevenue,
        ordersCount,
      ];
}

@JsonSerializable(createToJson: false)
class TechnicianProductivityStatistics extends Equatable {
 const TechnicianProductivityStatistics({
    required this.technicians,
    required this.totalTechnicians,
    required this.totalCompletedTasks,
  });

  final List<TechnicianProductivityItem>? technicians;

  @JsonKey(name: 'total_technicians')
  final int? totalTechnicians;

  @JsonKey(name: 'total_completed_tasks')
  final int? totalCompletedTasks;

  factory TechnicianProductivityStatistics.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TechnicianProductivityStatisticsFromJson(json);

  @override
  List<Object?> get props => [
        technicians,
        totalTechnicians,
        totalCompletedTasks,
      ];
}

@JsonSerializable(createToJson: false)
class TechnicianProductivityItem extends Equatable {
const  TechnicianProductivityItem({
    required this.technicianId,
    required this.name,
    required this.completedTasksCount,
  });

  @JsonKey(name: 'technician_id')
  final int? technicianId;

  final String? name;

  @JsonKey(name: 'completed_tasks_count')
  final int? completedTasksCount;

  factory TechnicianProductivityItem.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TechnicianProductivityItemFromJson(json);

  @override
  List<Object?> get props => [
        technicianId,
        name,
        completedTasksCount,
      ];
}

@JsonSerializable(createToJson: false)
class TopClinicsStatistics extends Equatable {
const  TopClinicsStatistics({
    required this.doctors,
  });

  final List<TopClinicItem>? doctors;

  factory TopClinicsStatistics.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TopClinicsStatisticsFromJson(json);

  @override
  List<Object?> get props => [
        doctors,
      ];
}

@JsonSerializable(createToJson: false)
class TopClinicItem extends Equatable {
  const TopClinicItem({
    required this.doctorId,
    required this.name,
    required this.ordersCount,
  });

  @JsonKey(name: 'doctor_id')
  final int? doctorId;

  final String? name;

  @JsonKey(name: 'orders_count')
  final int? ordersCount;

  factory TopClinicItem.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TopClinicItemFromJson(json);

  @override
  List<Object?> get props => [
        doctorId,
        name,
        ordersCount,
      ];
}

@JsonSerializable(createToJson: false)
class YearlyPerformanceStatistics extends Equatable {
const  YearlyPerformanceStatistics({
    required this.year,
    required this.months,
    required this.yearlyTotalRevenue,
    required this.yearlyTotalOrders,
    required this.yearlyCompletedOrders,
  });

  final int? year;

  final List<MonthlyPerformanceItem>? months;

  @JsonKey(name: 'yearly_total_revenue')
  final int? yearlyTotalRevenue;

  @JsonKey(name: 'yearly_total_orders')
  final int? yearlyTotalOrders;

  @JsonKey(name: 'yearly_completed_orders')
  final int? yearlyCompletedOrders;

  factory YearlyPerformanceStatistics.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$YearlyPerformanceStatisticsFromJson(json);

  @override
  List<Object?> get props => [
        year,
        months,
        yearlyTotalRevenue,
        yearlyTotalOrders,
        yearlyCompletedOrders,
      ];
}

@JsonSerializable(createToJson: false)
class MonthlyPerformanceItem extends Equatable {
const  MonthlyPerformanceItem({
    required this.month,
    required this.monthName,
    required this.ordersCount,
  });

  final int? month;

  @JsonKey(name: 'month_name')
  final String? monthName;

  @JsonKey(name: 'orders_count')
  final int? ordersCount;

  factory MonthlyPerformanceItem.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MonthlyPerformanceItemFromJson(json);

  @override
  List<Object?> get props => [
        month,
        monthName,
        ordersCount,
      ];
}