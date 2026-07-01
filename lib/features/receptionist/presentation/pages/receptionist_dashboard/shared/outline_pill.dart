import 'package:flutter/material.dart';


class OutlinePill extends StatelessWidget {
  final String label;
  final Color background;
  final Color borderColor;
  final Color textColor;

  const OutlinePill({
    super.key,
    required this.label,
    required this.background,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.brightness == Brightness.light 
              ? borderColor 
              : borderColor.withValues(alpha: 0.3), 
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w800,
          fontSize: 10,
        ),
      ),
    );
  }
}