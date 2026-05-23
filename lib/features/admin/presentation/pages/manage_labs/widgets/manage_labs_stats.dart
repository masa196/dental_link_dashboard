import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';

class ManageLabsStats extends StatelessWidget {
  const ManageLabsStats({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isDark = Theme.of(context).brightness == Brightness.dark;
        final int columns;
        if (width < ScreenSizes.mobile) {
          columns = 1;
        } else if (width < ScreenSizes.tablet) {
          columns = 2;
        } else {
          columns = 3;
        }

        final double spacing = AppSpacing.md;
        final double cardWidth = (width - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            SizedBox(
              width: cardWidth,
              child: _ManageStatCard(
                title: l10n.statsTotalLabs,
                value: '482',
                delta: '+12%',
                icon: Icons.science,
                iconBackground: isDark
                    ? AppDarkColors.infoSurface
                    : AppLightColors.infoSurface,
                iconColor: isDark
                    ? AppDarkColors.infoStrong
                    : AppLightColors.infoStrong,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _ManageStatCard(
                title: l10n.statsActiveLabs,
                value: '465',
                delta: '98%',
                icon: Icons.check_circle,
                iconBackground: isDark
                    ? AppDarkColors.successSurface
                    : AppLightColors.successSurface,
                iconColor: isDark
                    ? AppDarkColors.successStrong
                    : AppLightColors.successStrong,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _ManageStatCard(
                title: l10n.statsInactiveLabs,
                value: '17',
                delta: '2.4%',
                icon: Icons.info,
                iconBackground: isDark
                    ? AppDarkColors.alertSurface
                    : AppLightColors.alertSurface,
                iconColor: isDark
                    ? AppDarkColors.alertStrong
                    : AppLightColors.alertStrong,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ManageStatCard extends StatelessWidget {
  const _ManageStatCard({
    required this.title,
    required this.value,
    required this.delta,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  final String title;
  final String value;
  final String delta;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSizes.statsCardHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.mdMinus),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: AppSizes.statsShadowBlur,
            offset: Offset(0, AppSizes.statsShadowOffsetY),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.statsIconSize,
            height: AppSizes.statsIconSize,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: AppSpacing.mdMinus, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppTypography.fs18,
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: AppTypography.fs24,
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Text(
                    delta,
                    style: TextStyle(
                      fontSize: AppTypography.fs16,
                      color: iconColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
