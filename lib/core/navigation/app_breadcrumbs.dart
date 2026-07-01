import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';

class AppBreadcrumbItem {
  const AppBreadcrumbItem({
    required this.label,
    this.path,
    this.isActive = false,
  });

  final String label;
  final String? path;
  final bool isActive;
}

class AppBreadcrumbs extends StatelessWidget {
  const AppBreadcrumbs({super.key, required this.items});

  final List<AppBreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;
    return Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _BreadcrumbChip(item: items[index], scheme: scheme),
            if (index < items.length - 1)
              Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
          ],
        ],
      ),
    );
  }
}

class _BreadcrumbChip extends StatelessWidget {
  const _BreadcrumbChip({required this.item, required this.scheme});

  final AppBreadcrumbItem item;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final isClickable = item.path != null && !item.isActive;
    final textColor = item.isActive
        ? scheme.onSurface.withValues(alpha: 0.75)
        : scheme.primary;
    final style = TextStyle(
      color: textColor,
      fontSize: AppTypography.fs18,
      fontWeight: item.isActive ? FontWeight.w600 : FontWeight.w700,
    );

    if (!isClickable) {
      return Text(item.label, style: style);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => context.go(item.path!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Text(item.label, style: style),
      ),
    );
  }
}
