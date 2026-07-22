// ignore_for_file: deprecated_member_use

import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/timeline/models/order_timeline_step.dart';
import 'package:flutter/material.dart';


import 'timeline_indicator.dart';
import 'timeline_line.dart';

class OrderTimelineItem extends StatelessWidget {
  const OrderTimelineItem({
    super.key,
    required this.step,
    required this.isLast,
  });

  final OrderTimelineStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          SizedBox(
            width: 40,
            child: Column(
              children: [
                TimelineIndicator(step: step),

                if (!isLast)
                  Expanded(
                    child: TimelineLine(
                      color: step.color,
                      completed: step.isCompleted,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Task Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outline.withOpacity(.35)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Department + Status
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            step.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: step.color.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            step.statusLabel,
                            style: TextStyle(
                              color: step.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (step.employeeName.isNotEmpty) ...[
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Text(
                            "الموظف الذي يعمل على هذه الحالة : ",
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                              fontSize: 13,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              step.employeeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Progress
                    if (step.isCurrent) ...[
                      const SizedBox(height: 14),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: step.progress,
                          minHeight: 6,
                          color: step.color,
                          backgroundColor: scheme.outlineVariant.withOpacity(
                            .4,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
