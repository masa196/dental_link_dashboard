import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/dashboard_statistics/widgets/statistics_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TechnicianProductivityChart extends StatelessWidget {
  const TechnicianProductivityChart({
    super.key,
    required this.statistics,
  });

  final TechnicianProductivityStatistics? statistics;

  @override
  Widget build(BuildContext context) {
    final technicians = statistics?.technicians ?? [];

    if (technicians.isEmpty) {
      return Center(
        child: Text(
          'لا توجد بيانات للفنيين',
          style: TextStyle(
            color: StatisticsColors.textSecondary(context),
            fontSize: 12,
          ),
        ),
      );
    }

    final colors = StatisticsColors.technicianColors(context);

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: SizedBox(
              width: 170,
              height: 170,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,

                  // سماكة الحلقة
                  centerSpaceRadius: 40,

                  sections: List.generate(
                    technicians.length,
                    (index) {
                      final technician = technicians[index];

                      return PieChartSectionData(
                        value: (
                          technician.completedTasksCount ?? 0
                        ).toDouble(),

                        color: colors[index % colors.length],

                        // الحجم الخارجي
                        radius: 20,

                        showTitle: false,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                technicians.length,
                (index) {
                  final technician = technicians[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            technician.name ?? '-',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: StatisticsColors.textSecondary(
                                context,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 7),

                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}