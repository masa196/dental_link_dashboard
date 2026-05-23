import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';

class ManageLabsTableTabs extends StatelessWidget {
  const ManageLabsTableTabs({
    super.key,
    required this.l10n,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final AppLocalizations l10n;
  final LabsTabType selectedTab;
  final ValueChanged<LabsTabType> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color selectedColor = isDark
        ? AppDarkColors.accentStrong
        : AppLightColors.accentStrong;
    final Color unselectedColor = isDark
        ? AppDarkColors.hint
        : Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      height: AppSizes.tableTabsHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _TabButton(
              label: l10n.activeLabsTab,
              isSelected: selectedTab == LabsTabType.active,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
              onTap: () => onTabSelected(LabsTabType.active),
            ),
            const SizedBox(width: AppSpacing.lg),
            _TabButton(
              label: l10n.inactiveLabsTab,
              isSelected: selectedTab == LabsTabType.inactive,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
              onTap: () => onTabSelected(LabsTabType.inactive),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontSize: AppTypography.fs14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? selectedColor : unselectedColor,
              ),
              child: Text(label),
            ),
            const SizedBox(height: AppSpacing.xs),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 74,
              height: 2,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
