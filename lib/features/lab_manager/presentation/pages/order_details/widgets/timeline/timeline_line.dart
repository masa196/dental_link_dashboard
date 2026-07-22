import 'package:flutter/material.dart';

class TimelineLine extends StatelessWidget {
  const TimelineLine({
    super.key,
    required this.color,
    required this.completed,
  });

  final Color color;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: completed
            ? color
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}