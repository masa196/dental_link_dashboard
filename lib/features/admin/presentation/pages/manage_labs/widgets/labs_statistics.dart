import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/lab_statistics/lab_statistics_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/lab_statistics/lab_statistics_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';

class LabsStatistics extends StatelessWidget {
  const LabsStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<LabStatisticsBloc, LabStatisticsState>(
      builder: (context, state) {
        final isLoading = state.isLoading;
        final statistics = state.statistics;

        final totalLabs = statistics?.totalLabsCount;
        final activeLabs = statistics?.activeLabsCount;
        final inactiveLabs = statistics?.inactiveLabsCount;

        // Calculate percentages from the total number of labs.
        final double? activePercentage =
            totalLabs != null && totalLabs > 0 && activeLabs != null
            ? (activeLabs / totalLabs) * 100
            : null;

        final double? inactivePercentage =
            totalLabs != null && totalLabs > 0 && inactiveLabs != null
            ? (inactiveLabs / totalLabs) * 100
            : null;

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final isDark = Theme.of(context).brightness == Brightness.dark;

            final bool useHorizontalScroll = width < ScreenSizes.mobile;

            final cards = [
              // Total Labs
              _ManageStatCard(
                title: l10n.statsTotalLabs,
                value: totalLabs?.toString() ?? '--',
                isLoading: isLoading,
                icon: Icons.science,
                iconBackground: isDark
                    ? AppDarkColors.infoSurface
                    : AppLightColors.infoSurface,
                iconColor: isDark
                    ? AppDarkColors.infoStrong
                    : AppLightColors.infoStrong,
              ),

              // Active Labs
              _ManageStatCard(
                title: l10n.statsActiveLabs,
                value: activeLabs?.toString() ?? '--',
                percentage: activePercentage,
                isLoading: isLoading,
                icon: Icons.check_circle,
                iconBackground: isDark
                    ? AppDarkColors.successSurface
                    : AppLightColors.successSurface,
                iconColor: isDark
                    ? AppDarkColors.successStrong
                    : AppLightColors.successStrong,
              ),

              // Inactive Labs
              _ManageStatCard(
                title: l10n.statsInactiveLabs,
                value: inactiveLabs?.toString() ?? '--',
                percentage: inactivePercentage,
                isLoading: isLoading,
                icon: Icons.info,
                iconBackground: isDark
                    ? AppDarkColors.alertSurface
                    : AppLightColors.alertSurface,
                iconColor: isDark
                    ? AppDarkColors.alertStrong
                    : AppLightColors.alertStrong,
              ),
            ];

            // Small screens:
            // Cards remain horizontal and scrollable.
            if (useHorizontalScroll) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    for (int i = 0; i < cards.length; i++) ...[
                      SizedBox(width: 260, child: cards[i]),
                      if (i != cards.length - 1)
                        const SizedBox(width: AppSpacing.md),
                    ],
                  ],
                ),
              );
            }

            // Larger screens:
            // Cards share the available width equally.
            return Row(
              children: [
                for (int i = 0; i < cards.length; i++) ...[
                  Expanded(child: cards[i]),
                  if (i != cards.length - 1)
                    const SizedBox(width: AppSpacing.md),
                ],
              ],
            );
          },
        );
      },
    );
  }
}

class _ManageStatCard extends StatelessWidget {
  const _ManageStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    this.percentage,
    this.isLoading = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final double? percentage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 19, color: iconColor),
          ),

          const SizedBox(width: AppSpacing.xlPlus),

          // Title
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppTypography.fs16,
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Spacer(),

          // Value + Percentage / Loading
          if (isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppTypography.fs22,
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                if (percentage != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '${percentage!.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: AppTypography.fs14,
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
