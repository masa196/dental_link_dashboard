
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/system_logs/system_logs_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SystemLogCard extends StatelessWidget {
  const SystemLogCard({
    super.key,
    required this.log,
  });

  final SystemLogItem log;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;

    final level = log.level?.toLowerCase() ?? 'info';

    final levelData = _levelData(
      level: level,
      scheme: scheme,
      isArabic: isArabic,
    );

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LevelIndicator(
                icon: levelData.icon,
                backgroundColor: levelData.backgroundColor,
                iconColor: levelData.iconColor,
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _LevelBadge(
                          label: levelData.label,
                          backgroundColor: levelData.backgroundColor,
                          foregroundColor: levelData.iconColor,
                        ),

                        if (log.event != null && log.event!.isNotEmpty)
                          _EventBadge(
                            event: log.event!,
                            color: scheme.primary,
                          ),
                      ],
                    ),

                   // const SizedBox(height: 10),

                   /* Text(
                      log.message ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w600,
                        height: 1.45,
                      ),
                    ),*/
                  ],
                ),
              ),

              const SizedBox(width: 16),

              if (log.createdAt != null)
                _DateTimeLabel(
                  dateTime: log.createdAt!,
                  isArabic: isArabic,
                ),
            ],
          ),

          const SizedBox(height: 16),

          Divider(
            height: 1,
            color: scheme.outlineVariant.withValues(alpha: 0.35),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              _InfoItem(
                icon: Icons.person_outline_rounded,
                label: isArabic ? 'المستخدم' : 'User',
                value: log.user?.name ?? '—',
              ),

              _InfoItem(
                icon: Icons.email_outlined,
                label: isArabic ? 'البريد الإلكتروني' : 'Email',
                value: log.metadata?.email ?? '—',
              ),

          
            ],
          ),
        ],
      ),
    );
  }

  _LevelData _levelData({
    required String level,
    required ColorScheme scheme,
    required bool isArabic,
  }) {
    switch (level) {
      case 'error':
        return _LevelData(
          label: isArabic ? 'خطأ' : 'Error',
          icon: Icons.error_outline_rounded,
          backgroundColor: scheme.error.withValues(alpha: 0.10),
          iconColor: scheme.error,
        );

      case 'warning':
        return _LevelData(
          label: isArabic ? 'تحذير' : 'Warning',
          icon: Icons.warning_amber_rounded,
          backgroundColor: scheme.tertiary.withValues(alpha: 0.12),
          iconColor: scheme.tertiary,
        );

      case 'debug':
        return _LevelData(
          label: isArabic ? 'تصحيح' : 'Debug',
          icon: Icons.bug_report_outlined,
          backgroundColor: scheme.secondary.withValues(alpha: 0.12),
          iconColor: scheme.secondary,
        );

      case 'info':
      default:
        return _LevelData(
          label: isArabic ? 'معلومة' : 'Info',
          icon: Icons.info_outline_rounded,
          backgroundColor: scheme.primary.withValues(alpha: 0.10),
          iconColor: scheme.primary,
        );
    }
  }
}

class _LevelIndicator extends StatelessWidget {
  const _LevelIndicator({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 22,
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EventBadge extends StatelessWidget {
  const _EventBadge({
    required this.event,
    required this.color,
  });

  final String event;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        event,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 180,
        maxWidth: 320,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: scheme.onSurfaceVariant,
          ),

          const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTimeLabel extends StatelessWidget {
  const _DateTimeLabel({
    required this.dateTime,
    required this.isArabic,
  });

  final DateTime dateTime;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    final formattedDate = DateFormat(
      'dd/MM/yyyy',
     
    ).format(dateTime);

    final formattedTime = DateFormat(
      'HH:mm',
    ).format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule_outlined,
              size: 16,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 5),
            Text(
              formattedTime,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _LevelData {
  const _LevelData({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
}