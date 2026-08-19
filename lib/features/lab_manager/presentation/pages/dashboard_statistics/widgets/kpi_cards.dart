import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:flutter/material.dart';

class KpiCards extends StatelessWidget {
  const KpiCards({
    super.key,
    required this.averageDeliveryTime,
    required this.monthlyRevenue,
  });

  final AverageDeliveryTimeStatistics? averageDeliveryTime;
  final MonthlyRevenueStatistics? monthlyRevenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _KpiCard(
            title: 'متوسط وقت التسليم',
            value: _formatDouble(
              averageDeliveryTime?.averageDays,
            ),
            unit: 'أيام',
            icon: Icons.trending_down,
          ),
        ),

        const SizedBox(height: 24),

        Expanded(
          child: _KpiCard(
            title: 'إيرادات الشهر',
            value: _formatNumber(
              monthlyRevenue?.totalRevenue,
            ),
            unit: 'ر.س',
            icon: Icons.trending_up,
          ),
        ),
      ],
    );
  }

  static String _formatDouble(double? value) {
    if (value == null) {
      return '-';
    }

    return value % 1 == 0
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
  }

  static String _formatNumber(int? value) {
    if (value == null) {
      return '-';
    }

    return value.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppRadius.mdPlus,
        ),
        border: Border.all(
          color: colorScheme.outline,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(
              alpha: theme.brightness == Brightness.dark
                  ? 0.18
                  : 0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface.withValues(
                alpha: 0.65,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                unit,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface.withValues(
                    alpha: 0.65,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Text(
                value,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
        ],
      ),
    );
  }
}