import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';

import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';

class LoginInfoNote extends StatelessWidget {
  const LoginInfoNote({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mdMinus,
        vertical: AppSpacing.smPlus,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(
          alpha: AppSizes.alpha55,
        ),
        borderRadius: BorderRadius.circular(AppRadius.smPlus),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: AppSpacing.lgMinus,
            color: scheme.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.systemInfo,
              style: TextStyle(
                fontSize: AppTypography.fs12,
                color: scheme.onSurface.withValues(alpha: AppSizes.alpha72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
