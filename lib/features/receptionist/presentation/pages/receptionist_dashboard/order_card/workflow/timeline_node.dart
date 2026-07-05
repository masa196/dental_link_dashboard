import 'package:flutter/material.dart';

import 'models/workflow_step.dart';
import 'status_chip.dart';
import 'timeline_painter.dart';

class TimelineNode extends StatelessWidget {
  final WorkflowStep step;

  const TimelineNode({super.key, required this.step});

TimelineNodeState get state {

  if (step.progress >= 1) {
    return TimelineNodeState.completed;
  }

  if (step.isCurrent && step.hasStatus) {
    return TimelineNodeState.current;
  }

  return TimelineNodeState.pending;
}

  @override
  Widget build(BuildContext context) {
    final color = step.color;
    return SizedBox(
      width: 75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 42,
            height: 42,
            child: CustomPaint(
              painter: TimelinePainter(
                progress: step.progress,
                color: color,
                backgroundColor: const Color(0xffD1D5DB),
                state: state,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            step.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),

         if (step.isCurrent && step.hasStatus) ...[
  const SizedBox(height: 6),
  StatusChip(step: step),
],
        ],
      ),
    );
  }
}
