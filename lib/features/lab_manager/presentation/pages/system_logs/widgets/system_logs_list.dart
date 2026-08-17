import 'package:dental_link_dashboard/features/lab_manager/data/models/system_logs/system_logs_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/system_logs/widgets/system_log_card.dart';
import 'package:flutter/material.dart';

class SystemLogsList extends StatelessWidget {
  const SystemLogsList({
    super.key,
    required this.logs,
  });

  final List<SystemLogItem> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const _EmptySystemLogs();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: logs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return SystemLogCard(
          log: logs[index],
        );
      },
    );
  }
}

class _EmptySystemLogs extends StatelessWidget {
  const _EmptySystemLogs();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_toggle_off_rounded,
            size: 54,
            color: scheme.onSurfaceVariant.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد عمليات مسجلة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}