import 'package:flutter/material.dart';
import 'models/workflow_step.dart';

class WorkflowSection extends StatelessWidget {
  final List<WorkflowStep> steps;

  const WorkflowSection({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          return _WorkflowStepItem(
            step: step,
            isLast: isLast,
          );
        }),
      ),
    );
  }
}

class _WorkflowStepItem extends StatelessWidget {
  final WorkflowStep step;
  final bool isLast;

  const _WorkflowStepItem({
    required this.step,
    required this.isLast,
  });

  Color _getColor(BuildContext context) {
    switch (step.status) {
      case StepStatus.done:
        return const Color(0xFF22C55E);
      case StepStatus.active:
        return const Color(0xFF3B82F6);
      case StepStatus.rejected:
        return const Color(0xFFEF4444);
      case StepStatus.pending:
        return Theme.of(context).colorScheme.outline;
    }
  }

  IconData _getIcon() {
    switch (step.status) {
      case StepStatus.done:
        return Icons.check;
      case StepStatus.active:
        return Icons.sync;
      case StepStatus.rejected:
        return Icons.close;
      case StepStatus.pending:
        return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context);

    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
                color: color.withOpacity(0.1),
              ),
              child: Icon(_getIcon(), size: 18, color: color),
            ),

            const SizedBox(height: 6),

            SizedBox(
              width: 70,
              child: Text(
                step.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),

        if (!isLast)
          Container(
            width: 40,
            height: 2,
            margin: const EdgeInsets.only(bottom: 20),
            color: color,
          ),
      ],
    );
  }
}