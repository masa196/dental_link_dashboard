import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const HeaderContainer({
    super.key,
    required this.child,
    required this.height,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant,
          ),
        ),
      ),
      child: child,
    );
  }
}