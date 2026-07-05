import 'package:flutter/material.dart';

import 'models/workflow_step.dart';
import 'timeline_connector.dart';
import 'timeline_node.dart';

class WorkflowSection extends StatelessWidget {
  final List<WorkflowStep> steps;

  const WorkflowSection({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          steps.length * 2 - 1,
          (index) {
            if (index.isEven) {
              return TimelineNode(
                step: steps[index ~/ 2],
              );
            }

            return TimelineConnector(
              isCompleted:
                  steps[(index - 1) ~/ 2].progress >= 1,
            );
          },
        ),
      ),
    );
  }
}