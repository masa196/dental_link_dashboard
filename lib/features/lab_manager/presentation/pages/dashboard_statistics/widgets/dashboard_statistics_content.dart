import 'dart:math' as math;

import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';

import 'department_workload_chart.dart';
import 'kpi_cards.dart';
import 'statistics_card.dart';
import 'technician_productivity_chart.dart';
import 'top_doctors_chart.dart';
import 'yearly_performance_chart.dart';

class DashboardStatisticsContent extends StatelessWidget {
  const DashboardStatisticsContent({
    super.key,
    required this.data,
  });

  final DashboardStatisticsData data;

  static const double minPageWidth = 1100;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final pageWidth = math.max(
            constraints.maxWidth,
            minPageWidth,
          );

          return Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: pageWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        const DashboardHeader(
                          title: 'لوحة الإحصائيات',
                          showSearchBar: false,
                          showNotification: false,
                        ),

                        const SizedBox(height: 20),

                        _TopStatisticsSection(
                          data: data,
                        ),

                        const SizedBox(height: 20),

                        _BottomStatisticsSection(
                          data: data,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TopStatisticsSection extends StatelessWidget {
  const _TopStatisticsSection({
    required this.data,
  });

  final DashboardStatisticsData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: StatisticsCard(
              title: 'حجم العمل في الأقسام',
              icon: Icons.schema_outlined,
              child: DepartmentWorkloadChart(
                statistics: data.departmentWorkload,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            flex: 5,
            child: StatisticsCard(
              title: 'إنتاجية الفنيين',
              icon: Icons.engineering_outlined,
              child: TechnicianProductivityChart(
                statistics: data.technicianProductivity,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            flex: 3,
            child: KpiCards(
              averageDeliveryTime:
                  data.averageDeliveryTime,
              monthlyRevenue:
                  data.monthlyRevenue,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomStatisticsSection
    extends StatelessWidget {
  const _BottomStatisticsSection({
    required this.data,
  });

  final DashboardStatisticsData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: StatisticsCard(
              title: 'الأداء السنوي والتوجهات',
              subtitle:
                  'تطور حجم الطلبات الشهرية خلال العام الحالي',
              child: YearlyPerformanceChart(
                statistics:
                    data.yearlyPerformanceChart,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            flex: 4,
            child: StatisticsCard(
              title: 'رؤى العيادات والأطباء',
              subtitle:
                  'تحليل حجم التعامل لكل طبيب / عيادة',
              child: TopDoctorsChart(
                statistics: data.topClinics,
              ),
            ),
          ),
        ],
      ),
    );
  }
}