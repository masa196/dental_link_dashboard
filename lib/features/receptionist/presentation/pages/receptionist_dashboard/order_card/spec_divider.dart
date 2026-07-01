import 'package:flutter/material.dart';

class SpecDivider extends StatelessWidget {
  const SpecDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: 1,
      height: 32,
      color: theme.brightness == Brightness.light
          ? const Color(0xffE2E8F0)
          : scheme.outlineVariant
    );
  }
}