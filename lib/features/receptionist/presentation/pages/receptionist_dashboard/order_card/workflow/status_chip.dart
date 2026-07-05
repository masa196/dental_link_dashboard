// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'models/workflow_step.dart';

class StatusChip extends StatelessWidget {
  final WorkflowStep step;

  const StatusChip({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final color = step.color;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: color.withOpacity(.25),
          width: 1,
        ),
      ),
      child: Text(
        step.statusLabel,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: .2,
        ),
      ),
    );
  }
}