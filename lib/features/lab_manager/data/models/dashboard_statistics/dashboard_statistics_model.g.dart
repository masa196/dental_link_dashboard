// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatisticsResponse _$DashboardStatisticsResponseFromJson(
  Map<String, dynamic> json,
) => DashboardStatisticsResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DashboardStatisticsModel.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

DashboardStatisticsModel _$DashboardStatisticsModelFromJson(
  Map<String, dynamic> json,
) => DashboardStatisticsModel(
  averageDeliveryTime: json['average_delivery_time'] == null
      ? null
      : AverageDeliveryTimeModel.fromJson(
          json['average_delivery_time'] as Map<String, dynamic>,
        ),
  monthlyRevenue: json['monthly_revenue'] == null
      ? null
      : MonthlyRevenueModel.fromJson(
          json['monthly_revenue'] as Map<String, dynamic>,
        ),
  technicianProductivity: json['technician_productivity'] == null
      ? null
      : TechnicianProductivityModel.fromJson(
          json['technician_productivity'] as Map<String, dynamic>,
        ),
  departmentWorkload: json['department_workload'] == null
      ? null
      : DepartmentWorkloadModel.fromJson(
          json['department_workload'] as Map<String, dynamic>,
        ),
  topClinics: json['top_clinics'] == null
      ? null
      : TopClinicsModel.fromJson(json['top_clinics'] as Map<String, dynamic>),
  yearlyPerformanceChart: json['yearly_performance_chart'] == null
      ? null
      : YearlyPerformanceChartModel.fromJson(
          json['yearly_performance_chart'] as Map<String, dynamic>,
        ),
  dateRange: json['date_range'] == null
      ? null
      : StatisticsDateRangeModel.fromJson(
          json['date_range'] as Map<String, dynamic>,
        ),
);

AverageDeliveryTimeModel _$AverageDeliveryTimeModelFromJson(
  Map<String, dynamic> json,
) => AverageDeliveryTimeModel(
  averageDays: (json['average_days'] as num?)?.toInt(),
  averageHours: (json['average_hours'] as num?)?.toInt(),
  totalCompleted: (json['total_completed'] as num?)?.toInt(),
);

MonthlyRevenueModel _$MonthlyRevenueModelFromJson(Map<String, dynamic> json) =>
    MonthlyRevenueModel(
      totalRevenue: json['total_revenue'] as num?,
      ordersCount: (json['orders_count'] as num?)?.toInt(),
      averageOrderValue: json['average_order_value'] as num?,
    );

TechnicianProductivityModel _$TechnicianProductivityModelFromJson(
  Map<String, dynamic> json,
) => TechnicianProductivityModel(
  technicians: (json['technicians'] as List<dynamic>?)
      ?.map(
        (e) => TechnicianStatisticsModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  totalTechnicians: (json['total_technicians'] as num?)?.toInt(),
  totalCompletedTasks: (json['total_completed_tasks'] as num?)?.toInt(),
  totalWorkedHours: json['total_worked_hours'] as num?,
);

TechnicianStatisticsModel _$TechnicianStatisticsModelFromJson(
  Map<String, dynamic> json,
) => TechnicianStatisticsModel(
  technicianId: (json['technician_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  completedTasksCount: (json['completed_tasks_count'] as num?)?.toInt(),
  totalWorkedHours: json['total_worked_hours'] as num?,
  avgTimePerTaskHours: json['avg_time_per_task_hours'] as num?,
);

DepartmentWorkloadModel _$DepartmentWorkloadModelFromJson(
  Map<String, dynamic> json,
) => DepartmentWorkloadModel(
  departments: (json['departments'] as List<dynamic>?)
      ?.map(
        (e) => DepartmentStatisticsModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  totalTasks: (json['total_tasks'] as num?)?.toInt(),
  totalCompleted: (json['total_completed'] as num?)?.toInt(),
);

DepartmentStatisticsModel _$DepartmentStatisticsModelFromJson(
  Map<String, dynamic> json,
) => DepartmentStatisticsModel(
  departmentId: (json['department_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  pendingTasks: (json['pending_tasks'] as num?)?.toInt(),
  inProgressTasks: (json['in_progress_tasks'] as num?)?.toInt(),
  completedTasks: (json['completed_tasks'] as num?)?.toInt(),
  totalTasks: (json['total_tasks'] as num?)?.toInt(),
  completionRate: json['completion_rate'] as num?,
);

TopClinicsModel _$TopClinicsModelFromJson(Map<String, dynamic> json) =>
    TopClinicsModel(
      doctors: (json['doctors'] as List<dynamic>?)
          ?.map((e) => TopClinicDoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TopClinicDoctorModel _$TopClinicDoctorModelFromJson(
  Map<String, dynamic> json,
) => TopClinicDoctorModel(
  doctorId: (json['doctor_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  ordersCount: (json['orders_count'] as num?)?.toInt(),
  totalRevenue: json['total_revenue'] as num?,
);

YearlyPerformanceChartModel _$YearlyPerformanceChartModelFromJson(
  Map<String, dynamic> json,
) => YearlyPerformanceChartModel(
  year: (json['year'] as num?)?.toInt(),
  months: (json['months'] as List<dynamic>?)
      ?.map((e) => MonthlyPerformanceModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  yearlyTotalRevenue: json['yearly_total_revenue'] as num?,
  yearlyTotalOrders: (json['yearly_total_orders'] as num?)?.toInt(),
  yearlyCompletedOrders: (json['yearly_completed_orders'] as num?)?.toInt(),
);

MonthlyPerformanceModel _$MonthlyPerformanceModelFromJson(
  Map<String, dynamic> json,
) => MonthlyPerformanceModel(
  month: (json['month'] as num?)?.toInt(),
  monthName: json['month_name'] as String?,
  ordersCount: (json['orders_count'] as num?)?.toInt(),
  completedCount: (json['completed_count'] as num?)?.toInt(),
  revenue: json['revenue'] as num?,
  completionRate: json['completion_rate'] as num?,
);

StatisticsDateRangeModel _$StatisticsDateRangeModelFromJson(
  Map<String, dynamic> json,
) => StatisticsDateRangeModel(
  from: json['from'] as String?,
  to: json['to'] as String?,
);
