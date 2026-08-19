import 'dart:math' as math;

import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DepartmentWorkloadChart extends StatelessWidget {
  const DepartmentWorkloadChart({
    super.key,
    required this.statistics,
  });

  final DepartmentWorkloadStatistics? statistics;

  @override
  Widget build(BuildContext context) {
    final departments = statistics?.departments ?? [];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryColor =
        isDark ? AppDarkColors.primary : AppLightColors.primary;

    final successColor =
        isDark ? AppDarkColors.success : AppLightColors.success;

    final alertColor =
        isDark ? AppDarkColors.alert : AppLightColors.alert;

    final hintColor =
        isDark ? AppDarkColors.hint : AppLightColors.hint;

    final dividerColor =
        isDark ? AppDarkColors.divider : AppLightColors.divider;

    if (departments.isEmpty) {
      return Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'لا توجد بيانات للأقسام',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
              color: hintColor,
            ),
          ),
        ),
      );
    }

    final maxValue = departments.fold<int>(
      0,
      (previous, item) => math.max(
        previous,
        item.inProgressTasks ?? 0,
      ),
    );

    final chartMax = math.max(
      10,
      (maxValue * 1.2).ceil(),
    );

    return BarChart(
      BarChartData(
        maxY: chartMax.toDouble(),
        minY: 0,
        alignment: BarChartAlignment.spaceAround,

        barTouchData: BarTouchData(
          enabled: true,
        ),

        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _calculateInterval(chartMax),
          getDrawingHorizontalLine: (_) {
            return FlLine(
              color: dividerColor.withValues(alpha: 0.45),
              strokeWidth: 1,
            );
          },
        ),

        borderData: FlBorderData(
          show: false,
        ),

        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),

          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),

          // أرقام المحور العمودي
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: _calculateInterval(chartMax),
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 9,
                    color: hintColor,
                  ),
                );
              },
            ),
          ),

          // أسماء الأقسام
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();

                if (index < 0 || index >= departments.length) {
                  return const SizedBox.shrink();
                }

                final departmentName =
                    departments[index].name ?? '-';

                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: SizedBox(
                    width: 55,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          departmentName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        barGroups: List.generate(
          departments.length,
          (index) {
            final value =
                departments[index].inProgressTasks ?? 0;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value.toDouble(),

                  // سماكة الأعمدة
                  width: 12,

                  color: _workloadColor(
                    value,
                    maxValue,
                    primaryColor: primaryColor,
                    successColor: successColor,
                    alertColor: alertColor,
                  ),

                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _calculateInterval(num maxValue) {
    if (maxValue <= 20) return 5;
    if (maxValue <= 50) return 10;
    if (maxValue <= 100) return 20;
    return 25;
  }

  Color _workloadColor(
    int value,
    int maxValue, {
    required Color primaryColor,
    required Color successColor,
    required Color alertColor,
  }) {
    if (maxValue == 0) {
      return primaryColor;
    }

    final ratio = value / maxValue;

    if (ratio >= .75) {
      return alertColor;
    }

    if (ratio >= .4) {
      return successColor;
    }

    return primaryColor;
  }
}