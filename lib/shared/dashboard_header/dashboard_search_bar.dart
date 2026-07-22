  import 'package:flutter/material.dart';

  class DashboardSearchBar extends StatelessWidget {
    final ValueChanged<String>? onChanged;

    const DashboardSearchBar({super.key, this.onChanged});

    @override
    Widget build(BuildContext context) {
      final theme = Theme.of(context);
      final scheme = theme.colorScheme;

      return SizedBox(
        height: 38,
        child: TextField(
          onChanged: onChanged,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 14,
          ), // لون نص الكتابة دفيء
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 18,
              color: scheme.onSurfaceVariant,
            ),
            hintText: 'بحث سريع...',
            hintStyle: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
            filled: true,

            fillColor: theme.brightness == Brightness.light
                ? const Color(0xFFF8FAFC)
                : Color.alphaBlend(
                    Colors.white.withValues(alpha: 0.035),
                    scheme.surface,
                  ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: scheme.outline, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: scheme.primary, width: 1.5),
            ),
          ),
        ),
      );
    }
  }
