import 'package:flutter/material.dart';

class DoctorProgressBar extends StatelessWidget {
  const DoctorProgressBar({
    super.key,
    required this.totalPaid,
    required this.totalBilled,
  });

  final int totalPaid;
  final int totalBilled;

  double get percentage {
    if (totalBilled == 0) {
      return 0;
    }

    return (totalPaid / totalBilled).clamp(0, 1);
  }

  Color _progressColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final value = percentage * 100;

    if (value < 40) {
      return scheme.error;
    }

    if (value < 70) {
      return scheme.secondary;
    }

    return scheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = _progressColor(context);
    final percent = (percentage * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              "حالة السداد ($percent%)",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              "$totalPaid / $totalBilled",

              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: LinearProgressIndicator(
            value: percentage,

            minHeight: 8,

            backgroundColor: Colors.grey.withValues(alpha: 0.25),

            color: color,
          ),
        ),
      ],
    );
  }
}
