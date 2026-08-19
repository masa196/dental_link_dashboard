import 'dart:math' as math;

import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyPerformanceChart extends StatelessWidget {
  const YearlyPerformanceChart({super.key, required this.statistics});

  final YearlyPerformanceStatistics? statistics;

  @override
  Widget build(BuildContext context) {
    final months = statistics?.months ?? [];

    if (months.isEmpty) {
      return const Center(child: Text('لا توجد بيانات للأداء السنوي'));
    }

    final spots = List.generate(
      months.length,
      (index) =>
          FlSpot(index.toDouble(), (months[index].ordersCount ?? 0).toDouble()),
    );

    final maxValue = months.fold<int>(
      0,
      (previous, month) => math.max(previous, month.ordersCount ?? 0),
    );

    final chartMax = math.max(10, (maxValue * 1.2).ceil());

    return Column(
      children: [
       

        const SizedBox(height: 6),

        Expanded(
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: chartMax.toDouble(),
              minX: 0,
              maxX: math.max(0, months.length - 1).toDouble(),

              clipData: const FlClipData.none(),

              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (spots) {
                    return spots.map((spot) {
                      final index = spot.x.toInt();

                      if (index < 0 || index >= months.length) {
                        return null;
                      }

                      return LineTooltipItem(
                        '${months[index].monthName ?? '-'}\n'
                        '${spot.y.toInt()} طلب',
                        TextStyle(
                          color: AppLightColors.onPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),

              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: _calculateLineInterval(chartMax),
                getDrawingHorizontalLine: (_) {
                  return FlLine(
                    color: AppLightColors.divider.withValues(alpha: 0.45),
                    strokeWidth: 1,
                  );
                },
              ),

              borderData: FlBorderData(show: false),

              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    interval: _calculateLineInterval(chartMax),
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          fontSize: 9,
                          color: AppLightColors.hint,
                        ),
                      );
                    },
                  ),
                ),

                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 42,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();

                      if (index < 0 || index >= months.length) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          months[index].monthName ?? '-',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppLightColors.hint,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  curveSmoothness: .45,
                  color: AppLightColors.primary,
                  barWidth: 4,
                  isStrokeCapRound: true,

                  dotData: const FlDotData(show: false),

                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppLightColors.primary.withValues(alpha: .18),
                        AppLightColors.primary.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _calculateLineInterval(num maxValue) {
    if (maxValue <= 20) return 5;
    if (maxValue <= 50) return 10;
    if (maxValue <= 100) return 20;
    return 25;
  }
}
