import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class ManageLabsTableFooter extends StatelessWidget {
  const ManageLabsTableFooter({
    super.key,
    required this.currentPage,
    required this.lastPage,
    required this.from,
    required this.to,
    required this.total,
    required this.onPrevious,
    required this.onNext,
  });

  final int currentPage;
  final int lastPage;
  final int? from;
  final int? to;
  final int total;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color mutedText = isDark
        ? AppDarkColors.hint
        : context.scheme.onSurface;
    final Color iconColor = isDark
        ? AppDarkColors.accentStrong
        : context.scheme.primary;
    final Color footerBackground = isDark
        ? AppDarkColors.surfaceContainerHighest
        : AppLightColors.surfaceContainerHighest;
    final int safeLastPage = lastPage < 1 ? 1 : lastPage;
    final int safeCurrentPage = currentPage < 1 ? 1 : currentPage;

    return Container(
      decoration: BoxDecoration(
        color: footerBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.lg),
          bottomRight: Radius.circular(AppSpacing.lg),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.mdMinus,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _showingText(context, from, to, total),
            style: TextStyle(
              fontSize: AppTypography.fs12,
              color: mutedText.withValues(alpha: 0.7),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onPrevious,
                icon: Icon(
                  Icons.chevron_left,
                  size: AppSpacing.md,
                  color: onPrevious == null
                      ? mutedText.withValues(alpha: 0.35)
                      : iconColor,
                ),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppSizes.tablePagerDotSize,
                  minHeight: AppSizes.tablePagerDotSize,
                ),
              ),
              const SizedBox(width: AppSpacing.mdMinus),
              Text(
                '$safeCurrentPage',
                style: TextStyle(
                  fontSize: AppTypography.fs12,
                  color: mutedText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.mdMinus),
              Text(
                '/ $safeLastPage',
                style: TextStyle(
                  fontSize: AppTypography.fs12,
                  color: mutedText,
                ),
              ),
              const SizedBox(width: AppSpacing.mdMinus),
              IconButton(
                onPressed: onNext,
                icon: Icon(
                  Icons.chevron_right,
                  size: AppSpacing.md,
                  color: onNext == null
                      ? mutedText.withValues(alpha: 0.35)
                      : iconColor,
                ),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppSizes.tablePagerDotSize,
                  minHeight: AppSizes.tablePagerDotSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _showingText(BuildContext context, int? from, int? to, int total) {
    final int safeFrom = from ?? 0;
    final int safeTo = to ?? 0;

    if (context.isArabic) {
      return 'عرض $safeFrom إلى $safeTo من $total مخبر';
    }

    return 'Showing $safeFrom to $safeTo of $total labs';
  }
}
