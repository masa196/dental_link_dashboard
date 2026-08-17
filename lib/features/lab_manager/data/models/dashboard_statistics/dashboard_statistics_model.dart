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
  final DashboardStatisticsModel? data;
  final dynamic errors;

  factory DashboardStatisticsResponse.fromJson(Map<String, dynamic> json) =>
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
class DashboardStatisticsModel extends Equatable {
  const DashboardStatisticsModel({
    required this.averageDeliveryTime,
    required this.monthlyRevenue,
    required this.technicianProductivity,
    required this.departmentWorkload,
    required this.topClinics,
    required this.yearlyPerformanceChart,
    required this.dateRange,
  });

  @JsonKey(name: 'average_delivery_time')
  final AverageDeliveryTimeModel? averageDeliveryTime;

  @JsonKey(name: 'monthly_revenue')
  final MonthlyRevenueModel? monthlyRevenue;

  @JsonKey(name: 'technician_productivity')
  final TechnicianProductivityModel? technicianProductivity;

  @JsonKey(name: 'department_workload')
  final DepartmentWorkloadModel? departmentWorkload;

  @JsonKey(name: 'top_clinics')
  final TopClinicsModel? topClinics;

  @JsonKey(name: 'yearly_performance_chart')
  final YearlyPerformanceChartModel? yearlyPerformanceChart;

  @JsonKey(name: 'date_range')
  final StatisticsDateRangeModel? dateRange;


  factory DashboardStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatisticsModelFromJson(json);

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
class AverageDeliveryTimeModel extends Equatable {
  const AverageDeliveryTimeModel({
    required this.averageDays,
    required this.averageHours,
    required this.totalCompleted,
  });

  @JsonKey(name: 'average_days')
  final int? averageDays;

  @JsonKey(name: 'average_hours')
  final int? averageHours;

  @JsonKey(name: 'total_completed')
  final int? totalCompleted;

  factory AverageDeliveryTimeModel.fromJson(Map<String, dynamic> json) =>
      _$AverageDeliveryTimeModelFromJson(json);

  @override
  List<Object?> get props => [
        averageDays,
        averageHours,
        totalCompleted,
      ];
}

@JsonSerializable(createToJson: false)
class MonthlyRevenueModel extends Equatable {
  const MonthlyRevenueModel({
    required this.totalRevenue,
    required this.ordersCount,
    required this.averageOrderValue,
  });

  @JsonKey(name: 'total_revenue')
  final num? totalRevenue;

  @JsonKey(name: 'orders_count')
  final int? ordersCount;

  @JsonKey(name: 'average_order_value')
  final num? averageOrderValue;

  factory MonthlyRevenueModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRevenueModelFromJson(json);

  @override
  List<Object?> get props => [
        totalRevenue,
        ordersCount,
        averageOrderValue,
      ];
}

@JsonSerializable(createToJson: false)
class TechnicianProductivityModel extends Equatable {
  const TechnicianProductivityModel({
    required this.technicians,
    required this.totalTechnicians,
    required this.totalCompletedTasks,
    required this.totalWorkedHours,
  });

  final List<TechnicianStatisticsModel>? technicians;

  @JsonKey(name: 'total_technicians')
  final int? totalTechnicians;

  @JsonKey(name: 'total_completed_tasks')
  final int? totalCompletedTasks;

  @JsonKey(name: 'total_worked_hours')
  final num? totalWorkedHours;

  factory TechnicianProductivityModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TechnicianProductivityModelFromJson(json);

  @override
  List<Object?> get props => [
        technicians,
        totalTechnicians,
        totalCompletedTasks,
        totalWorkedHours,
      ];
}

@JsonSerializable(createToJson: false)
class TechnicianStatisticsModel extends Equatable {
  const TechnicianStatisticsModel({
    required this.technicianId,
    required this.name,
    required this.completedTasksCount,
    required this.totalWorkedHours,
    required this.avgTimePerTaskHours,
  });

  @JsonKey(name: 'technician_id')
  final int? technicianId;

  final String? name;

  @JsonKey(name: 'completed_tasks_count')
  final int? completedTasksCount;

  @JsonKey(name: 'total_worked_hours')
  final num? totalWorkedHours;

  @JsonKey(name: 'avg_time_per_task_hours')
  final num? avgTimePerTaskHours;

  factory TechnicianStatisticsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TechnicianStatisticsModelFromJson(json);

  @override
  List<Object?> get props => [
        technicianId,
        name,
        completedTasksCount,
        totalWorkedHours,
        avgTimePerTaskHours,
      ];
}

@JsonSerializable(createToJson: false)
class DepartmentWorkloadModel extends Equatable {
  const DepartmentWorkloadModel({
    required this.departments,
    required this.totalTasks,
    required this.totalCompleted,
  });

  final List<DepartmentStatisticsModel>? departments;

  @JsonKey(name: 'total_tasks')
  final int? totalTasks;

  @JsonKey(name: 'total_completed')
  final int? totalCompleted;

  factory DepartmentWorkloadModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DepartmentWorkloadModelFromJson(json);

  @override
  List<Object?> get props => [
        departments,
        totalTasks,
        totalCompleted,
      ];
}

@JsonSerializable(createToJson: false)
class DepartmentStatisticsModel extends Equatable {
  const DepartmentStatisticsModel({
    required this.departmentId,
    required this.name,
    required this.pendingTasks,
    required this.inProgressTasks,
    required this.completedTasks,
    required this.totalTasks,
    required this.completionRate,
  });

  @JsonKey(name: 'department_id')
  final int? departmentId;

  final String? name;

  @JsonKey(name: 'pending_tasks')
  final int? pendingTasks;

  @JsonKey(name: 'in_progress_tasks')
  final int? inProgressTasks;

  @JsonKey(name: 'completed_tasks')
  final int? completedTasks;

  @JsonKey(name: 'total_tasks')
  final int? totalTasks;

  @JsonKey(name: 'completion_rate')
  final num? completionRate;

  factory DepartmentStatisticsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DepartmentStatisticsModelFromJson(json);

  @override
  List<Object?> get props => [
        departmentId,
        name,
        pendingTasks,
        inProgressTasks,
        completedTasks,
        totalTasks,
        completionRate,
      ];
}

@JsonSerializable(createToJson: false)
class TopClinicsModel extends Equatable {
  const TopClinicsModel({
    required this.doctors,
  });

  final List<TopClinicDoctorModel>? doctors;

  factory TopClinicsModel.fromJson(Map<String, dynamic> json) =>
      _$TopClinicsModelFromJson(json);

  @override
  List<Object?> get props => [
        doctors,
      ];
}

@JsonSerializable(createToJson: false)
class TopClinicDoctorModel extends Equatable {
  const TopClinicDoctorModel({
    required this.doctorId,
    required this.name,
    required this.ordersCount,
    required this.totalRevenue,
  });

  @JsonKey(name: 'doctor_id')
  final int? doctorId;

  final String? name;

  @JsonKey(name: 'orders_count')
  final int? ordersCount;

  @JsonKey(name: 'total_revenue')
  final num? totalRevenue;

  factory TopClinicDoctorModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TopClinicDoctorModelFromJson(json);

  @override
  List<Object?> get props => [
        doctorId,
        name,
        ordersCount,
        totalRevenue,
      ];
}

@JsonSerializable(createToJson: false)
class YearlyPerformanceChartModel extends Equatable {
  const YearlyPerformanceChartModel({
    required this.year,
    required this.months,
    required this.yearlyTotalRevenue,
    required this.yearlyTotalOrders,
    required this.yearlyCompletedOrders,
  });

  final int? year;

  final List<MonthlyPerformanceModel>? months;

  @JsonKey(name: 'yearly_total_revenue')
  final num? yearlyTotalRevenue;

  @JsonKey(name: 'yearly_total_orders')
  final int? yearlyTotalOrders;

  @JsonKey(name: 'yearly_completed_orders')
  final int? yearlyCompletedOrders;

  factory YearlyPerformanceChartModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$YearlyPerformanceChartModelFromJson(json);

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
class MonthlyPerformanceModel extends Equatable {
  const MonthlyPerformanceModel({
    required this.month,
    required this.monthName,
    required this.ordersCount,
    required this.completedCount,
    required this.revenue,
    required this.completionRate,
  });

  final int? month;

  @JsonKey(name: 'month_name')
  final String? monthName;

  @JsonKey(name: 'orders_count')
  final int? ordersCount;

  @JsonKey(name: 'completed_count')
  final int? completedCount;

  final num? revenue;

  @JsonKey(name: 'completion_rate')
  final num? completionRate;

  factory MonthlyPerformanceModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MonthlyPerformanceModelFromJson(json);

  @override
  List<Object?> get props => [
        month,
        monthName,
        ordersCount,
        completedCount,
        revenue,
        completionRate,
      ];
}

@JsonSerializable(createToJson: false)
class StatisticsDateRangeModel extends Equatable {
  const StatisticsDateRangeModel({
    required this.from,
    required this.to,
  });

  final String? from;
  final String? to;

  factory StatisticsDateRangeModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$StatisticsDateRangeModelFromJson(json);

  @override
  List<Object?> get props => [
        from,
        to,
      ];
}