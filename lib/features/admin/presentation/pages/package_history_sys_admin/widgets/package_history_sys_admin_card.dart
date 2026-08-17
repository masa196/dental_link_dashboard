import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/admin/data/models/package_history_sys_admin/package_history_sys_admin_model.dart';

class PackageHistorySysAdminCard extends StatelessWidget {
  const PackageHistorySysAdminCard({
    super.key,
    required this.item,
    required this.availableWidth,
  });

  final Datum item;
  final double availableWidth;

  @override
  Widget build(BuildContext context) {
    final package = item.package;

    final assignedAt = item.assignedAt;
    final durationDays = package?.durationDays;

    final bool hasValidDates =
        assignedAt != null && durationDays != null && durationDays > 0;

    final DateTime? expirationDate = hasValidDates
        ? assignedAt.add(
            Duration(days: durationDays),
          )
        : null;

    final PackageStatus status = _calculateStatus(
      item: item,
      expirationDate: expirationDate,
    );

    final int? remainingDays = _calculateRemainingDays(
      status: status,
      expirationDate: expirationDate,
    );

    final double progress = _calculateProgress(
      assignedAt: assignedAt,
      expirationDate: expirationDate,
      status: status,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PackageCardHeader(
                name: package?.name ?? '—',
                status: status,
              ),

              const SizedBox(height: AppSpacing.lg),

              if (compact)
                _CompactPackageInfo(
                  assignedAt: assignedAt,
                  durationDays: durationDays,
                  expirationDate: expirationDate,
                  remainingDays: remainingDays,
                  status: status,
                )
              else
                _WidePackageInfo(
                  assignedAt: assignedAt,
                  durationDays: durationDays,
                  expirationDate: expirationDate,
                  remainingDays: remainingDays,
                  status: status,
                ),

              if (status == PackageStatus.active &&
                  expirationDate != null) ...[
                const SizedBox(height: AppSpacing.lg),

                _PackageProgress(
                  progress: progress,
                  remainingDays: remainingDays ?? 0,
                ),
              ],

              if (item.unassignedAt != null) ...[
                const SizedBox(height: AppSpacing.md),

                _UnassignedInfo(
                  unassignedAt: item.unassignedAt!,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  PackageStatus _calculateStatus({
    required Datum item,
    required DateTime? expirationDate,
  }) {
    if (item.unassignedAt != null) {
      return PackageStatus.inactive;
    }

    if (expirationDate == null) {
      return PackageStatus.unknown;
    }

    if (DateTime.now().isAfter(expirationDate)) {
      return PackageStatus.expired;
    }

    return PackageStatus.active;
  }

  int? _calculateRemainingDays({
    required PackageStatus status,
    required DateTime? expirationDate,
  }) {
    if (status != PackageStatus.active || expirationDate == null) {
      return null;
    }

    final difference = expirationDate.difference(DateTime.now());

    if (difference.isNegative) {
      return 0;
    }

    return math.max(
      1,
      (difference.inHours / 24).ceil(),
    );
  }

  double _calculateProgress({
    required DateTime? assignedAt,
    required DateTime? expirationDate,
    required PackageStatus status,
  }) {
    if (status != PackageStatus.active ||
        assignedAt == null ||
        expirationDate == null) {
      return 0;
    }

    final total = expirationDate.difference(assignedAt).inSeconds;

    if (total <= 0) {
      return 0;
    }

    final elapsed = DateTime.now().difference(assignedAt).inSeconds;

    return (elapsed / total).clamp(0.0, 1.0);
  }
}

enum PackageStatus {
  active,
  expired,
  inactive,
  unknown,
}


class _PackageCardHeader extends StatelessWidget {
  const _PackageCardHeader({
    required this.name,
    required this.status,
  });

  final String name;
  final PackageStatus status;

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    final Color accent =
        isDark ? AppDarkColors.accent : AppLightColors.accent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: AppTypography.fs16,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        _PackageStatusChip(
          status: status,
        ),
      ],
    );
  }
}

class _PackageStatusChip extends StatelessWidget {
  const _PackageStatusChip({
    required this.status,
  });

  final PackageStatus status;

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    late final String text;
    late final Color color;

    switch (status) {
      case PackageStatus.active:
        text = context.isArabic ? 'نشطة' : 'Active';
        color = isDark
            ? AppDarkColors.success
            : AppLightColors.success;
        break;

      case PackageStatus.expired:
        text = context.isArabic ? 'منتهية' : 'Expired';
        color = isDark
            ? AppDarkColors.alert
            : AppLightColors.alert;
        break;

      case PackageStatus.inactive:
        text = context.isArabic ? 'غير نشطة' : 'Inactive';
        color = Theme.of(context).colorScheme.outline;
        break;

      case PackageStatus.unknown:
        text = context.isArabic ? 'غير متوفر' : 'Unavailable';
        color = Theme.of(context).colorScheme.outline;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppTypography.fs12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _WidePackageInfo extends StatelessWidget {
  const _WidePackageInfo({
    required this.assignedAt,
    required this.durationDays,
    required this.expirationDate,
    required this.remainingDays,
    required this.status,
  });

  final DateTime? assignedAt;
  final int? durationDays;
  final DateTime? expirationDate;
  final int? remainingDays;
  final PackageStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PackageInfoItem(
            icon: Icons.calendar_today_outlined,
            title: context.isArabic
                ? 'تاريخ الإسناد'
                : 'Assigned at',
            value: assignedAt != null
                ? _formatDate(assignedAt!)
                : '—',
          ),
        ),

        Expanded(
          child: _PackageInfoItem(
            icon: Icons.timelapse_outlined,
            title: context.isArabic
                ? 'مدة الباقة'
                : 'Duration',
            value: durationDays != null
                ? context.isArabic
                    ? '$durationDays يوم'
                    : '$durationDays days'
                : '—',
          ),
        ),

        Expanded(
          child: _PackageInfoItem(
            icon: Icons.event_outlined,
            title: context.isArabic
                ? 'تاريخ الانتهاء'
                : 'Expiration',
            value: expirationDate != null
                ? _formatDate(expirationDate!)
                : '—',
          ),
        ),

        Expanded(
          child: _PackageInfoItem(
            icon: Icons.hourglass_bottom_outlined,
            title: context.isArabic
                ? 'المتبقي'
                : 'Remaining',
            value: _remainingText(
              context,
              remainingDays,
              status,
            ),
          ),
        ),
      ],
    );
  }
}


class _CompactPackageInfo extends StatelessWidget {
  const _CompactPackageInfo({
    required this.assignedAt,
    required this.durationDays,
    required this.expirationDate,
    required this.remainingDays,
    required this.status,
  });

  final DateTime? assignedAt;
  final int? durationDays;
  final DateTime? expirationDate;
  final int? remainingDays;
  final PackageStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _PackageInfoItem(
                icon: Icons.calendar_today_outlined,
                title: context.isArabic
                    ? 'تاريخ الإسناد'
                    : 'Assigned at',
                value: assignedAt != null
                    ? _formatDate(assignedAt!)
                    : '—',
              ),
            ),

            Expanded(
              child: _PackageInfoItem(
                icon: Icons.timelapse_outlined,
                title: context.isArabic
                    ? 'المدة'
                    : 'Duration',
                value: durationDays != null
                    ? context.isArabic
                        ? '$durationDays يوم'
                        : '$durationDays days'
                    : '—',
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        Row(
          children: [
            Expanded(
              child: _PackageInfoItem(
                icon: Icons.event_outlined,
                title: context.isArabic
                    ? 'تاريخ الانتهاء'
                    : 'Expiration',
                value: expirationDate != null
                    ? _formatDate(expirationDate!)
                    : '—',
              ),
            ),

            Expanded(
              child: _PackageInfoItem(
                icon: Icons.hourglass_bottom_outlined,
                title: context.isArabic
                    ? 'المتبقي'
                    : 'Remaining',
                value: _remainingText(
                  context,
                  remainingDays,
                  status,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PackageInfoItem extends StatelessWidget {
  const _PackageInfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppSpacing.lg,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(width: AppSpacing.sm),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppTypography.fs12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxs),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppTypography.fs14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _remainingText(
  BuildContext context,
  int? remainingDays,
  PackageStatus status,
) {
  switch (status) {
    case PackageStatus.active:
      if (remainingDays == null) {
        return '—';
      }

      return context.isArabic
          ? '$remainingDays يوم'
          : '$remainingDays days';

    case PackageStatus.expired:
      return context.isArabic
          ? 'انتهت الباقة'
          : 'Expired';

    case PackageStatus.inactive:
      return context.isArabic
          ? 'تم إلغاء الإسناد'
          : 'Unassigned';

    case PackageStatus.unknown:
      return '—';
  }
}


class _PackageProgress extends StatelessWidget {
  const _PackageProgress({
    required this.progress,
    required this.remainingDays,
  });

  final double progress;
  final int remainingDays;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.isArabic
                    ? 'مدة الباقة المستخدمة'
                    : 'Package progress',
                style: TextStyle(
                  fontSize: AppTypography.fs12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
              ),
            ),

            Text(
              context.isArabic
                  ? 'متبقي $remainingDays يوم'
                  : '$remainingDays days left',
              style: TextStyle(
                fontSize: AppTypography.fs12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}


class _UnassignedInfo extends StatelessWidget {
  const _UnassignedInfo({
    required this.unassignedAt,
  });

  final DateTime unassignedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Text(
        context.isArabic
            ? 'تم إلغاء إسناد الباقة بتاريخ ${_formatDate(unassignedAt)}'
            : 'Package unassigned on ${_formatDate(unassignedAt)}',
        style: TextStyle(
          fontSize: AppTypography.fs12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}



String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}