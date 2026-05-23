import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "DentalLink",
                style: TextStyle(
                  fontSize: AppTypography.fs24,
                  fontWeight: FontWeight.bold,
                  color: scheme.primary,
                ),
              ),
              SizedBox(width: AppSpacing.smPlus),
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(AppRadius.smPlus),
                ),
                child: SvgPicture.asset(
                  'assets/icons/tooth.svg',
                  width: AppSpacing.lgMinus,
                  height: AppSpacing.lgMinus,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.loginTitle,
            style: TextStyle(
              fontSize: AppTypography.fs22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xsPlus),
          Text(
            l10n.loginSubtitle,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: AppSizes.alpha7),
            ),
          ),
        ],
      ),
    );
  }
}
