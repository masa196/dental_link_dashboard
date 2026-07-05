// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CardSectionDivider extends StatelessWidget {
  const CardSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: 1,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: theme.brightness == Brightness.light
          ? const Color(0xffF1F5F9)
          : scheme.outlineVariant.withOpacity(.15),
    );
  }
}