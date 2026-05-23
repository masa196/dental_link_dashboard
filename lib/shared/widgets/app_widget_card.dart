import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class AppWidgetCard extends StatelessWidget {
  const AppWidgetCard({
    super.key,
    required this.title,
    required this.value,
    required this.hint,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  final String title;
  final String value;
  final String hint;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSpacing.widgetCardHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.mdPlus),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          Container(
            width: AppSpacing.xl - AppSpacing.xxs,
            height: AppSpacing.xl - AppSpacing.xxs,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: AppSpacing.lgMinus, color: iconColor),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: AppTypography.fs14,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            value,
            style: TextStyle(
              fontSize: AppTypography.fs32,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
              height: AppSizes.widgetCardValueHeight,
            ),
          ),
          const SizedBox(width: AppSpacing.xsPlus),
          Text(
            hint,
            style: TextStyle(
              fontSize: AppTypography.fs10,
              color: scheme.onSurface.withValues(alpha: AppSizes.alpha6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
