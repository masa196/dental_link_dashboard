import 'package:flutter/material.dart';

class PermissionCheckbox extends StatelessWidget {
  const PermissionCheckbox({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final color = value ? scheme.primary : scheme.outline.withValues(alpha: .4);

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: value
              ? scheme.primary.withValues(alpha: .12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color, width: 1.4),
        ),
        child: value
            ? Icon(Icons.check, size: 20, color: scheme.primary)
            : null,
      ),
    );
  }
}
