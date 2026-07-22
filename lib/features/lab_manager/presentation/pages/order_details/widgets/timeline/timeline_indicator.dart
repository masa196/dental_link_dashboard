import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/timeline/models/order_timeline_step.dart';
import 'package:flutter/material.dart';

class TimelineIndicator extends StatelessWidget {
  const TimelineIndicator({super.key, required this.step});

  final OrderTimelineStep step;

  @override
  Widget build(BuildContext context) {
    final color = step.color;

    if (step.isCompleted) {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: const Icon(Icons.check, color: Colors.white, size: 18),
      );
    }

    if (step.isCurrent) {
      return Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 3.5),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      );
    }

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
    );
  }
}
