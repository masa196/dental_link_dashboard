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
      : DashboardStatisticsData.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

DashboardStatisticsData _$DashboardStatisticsDataFromJson(
  Map<String, dynamic> json,
) => DashboardStatisticsData(
  averageDeliveryTime: json['average_delivery_time'] == null
      ? null
      : AverageDeliveryTimeStatistics.fromJson(
          json['average_delivery_time'] as Map<String, dynamic>,
        ),
  monthlyRevenue: json['monthly_revenue'] == null
      ? null
      : MonthlyRevenueStatistics.fromJson(
          json['monthly_revenue'] as Map<String, dynamic>,
        ),
  technicianProductivity: json['technician_productivity'] == null
      ? null
      : TechnicianProductivityStatistics.fromJson(
          json['technician_productivity'] as Map<String, dynamic>,
        ),
  departmentWorkload: json['department_workload'] == null
      ? null
      : DepartmentWorkloadStatistics.fromJson(
          json['department_workload'] as Map<String, dynamic>,
        ),
  topClinics: json['top_clinics'] == null
      ? null
      : TopClinicsStatistics.fromJson(
          json['top_clinics'] as Map<String, dynamic>,
        ),
  yearlyPerformanceChart: json['yearly_performance_chart'] == null
      ? null
      : YearlyPerformanceStatistics.fromJson(
          json['yearly_performance_chart'] as Map<String, dynamic>,
        ),
  dateRange: json['date_range'] == null
      ? null
      : StatisticsDateRange.fromJson(
          json['date_range'] as Map<String, dynamic>,
        ),
);

AverageDeliveryTimeStatistics _$AverageDeliveryTimeStatisticsFromJson(
  Map<String, dynamic> json,
) => AverageDeliveryTimeStatistics(
  averageDays: (json['average_days'] as num?)?.toDouble(),
);

StatisticsDateRange _$StatisticsDateRangeFromJson(Map<String, dynamic> json) =>
    StatisticsDateRange(
      from: json['from'] == null
          ? null
          : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    );

DepartmentWorkloadStatistics _$DepartmentWorkloadStatisticsFromJson(
  Map<String, dynamic> json,
) => DepartmentWorkloadStatistics(
  departments: (json['departments'] as List<dynamic>?)
      ?.map((e) => DepartmentWorkloadItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

DepartmentWorkloadItem _$DepartmentWorkloadItemFromJson(
  Map<String, dynamic> json,
) => DepartmentWorkloadItem(
  departmentId: (json['department_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  inProgressTasks: (json['in_progress_tasks'] as num?)?.toInt(),
);

MonthlyRevenueStatistics _$MonthlyRevenueStatisticsFromJson(
  Map<String, dynamic> json,
) => MonthlyRevenueStatistics(
  totalRevenue: (json['total_revenue'] as num?)?.toInt(),
  ordersCount: (json['orders_count'] as num?)?.toInt(),
);

TechnicianProductivityStatistics _$TechnicianProductivityStatisticsFromJson(
  Map<String, dynamic> json,
) => TechnicianProductivityStatistics(
  technicians: (json['technicians'] as List<dynamic>?)
      ?.map(
        (e) => TechnicianProductivityItem.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  totalTechnicians: (json['total_technicians'] as num?)?.toInt(),
  totalCompletedTasks: (json['total_completed_tasks'] as num?)?.toInt(),
);

TechnicianProductivityItem _$TechnicianProductivityItemFromJson(
  Map<String, dynamic> json,
) => TechnicianProductivityItem(
  technicianId: (json['technician_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  completedTasksCount: (json['completed_tasks_count'] as num?)?.toInt(),
);

TopClinicsStatistics _$TopClinicsStatisticsFromJson(
  Map<String, dynamic> json,
) => TopClinicsStatistics(
  doctors: (json['doctors'] as List<dynamic>?)
      ?.map((e) => TopClinicItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

TopClinicItem _$TopClinicItemFromJson(Map<String, dynamic> json) =>
    TopClinicItem(
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      ordersCount: (json['orders_count'] as num?)?.toInt(),
    );

YearlyPerformanceStatistics _$YearlyPerformanceStatisticsFromJson(
  Map<String, dynamic> json,
) => YearlyPerformanceStatistics(
  year: (json['year'] as num?)?.toInt(),
  months: (json['months'] as List<dynamic>?)
      ?.map((e) => MonthlyPerformanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  yearlyTotalRevenue: (json['yearly_total_revenue'] as num?)?.toInt(),
  yearlyTotalOrders: (json['yearly_total_orders'] as num?)?.toInt(),
  yearlyCompletedOrders: (json['yearly_completed_orders'] as num?)?.toInt(),
);

MonthlyPerformanceItem _$MonthlyPerformanceItemFromJson(
  Map<String, dynamic> json,
) => MonthlyPerformanceItem(
  month: (json['month'] as num?)?.toInt(),
  monthName: json['month_name'] as String?,
  ordersCount: (json['orders_count'] as num?)?.toInt(),
);
