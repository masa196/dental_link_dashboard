import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    this.iconColor,
    this.onChanged,
    this.validator,
    this.errorText,
    this.readOnly = false,
    this.onTap,
  });

  final String hint;
  final IconData icon;

  /// NEW
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final bool obscureText;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final Color? iconColor;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  /// OPTIONAL UX
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      textAlign: textAlign,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,

      style: TextStyle(fontSize: AppTypography.fs14, color: scheme.onSurface),

      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            hintStyle ??
            theme.inputDecorationTheme.hintStyle ??
            TextStyle(
              color: scheme.onSurface.withValues(alpha: AppSizes.alpha6),
              fontSize: AppTypography.fs13,
            ),

        prefixIcon: Icon(
          icon,
          color:
              iconColor ?? scheme.onSurface.withValues(alpha: AppSizes.alpha62),
        ),

        suffixIcon: suffixIcon,
        errorText: errorText,

        filled: true,
        fillColor:
            theme.inputDecorationTheme.fillColor ??
            scheme.surfaceContainerHighest,

        enabledBorder:
            theme.inputDecorationTheme.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppRadius.pill,
              ), // 👈 مطابق للتصميم
              borderSide: BorderSide(
                color: theme.dividerColor,
                width: AppSizes.borderWidthSm,
              ),
            ),

        focusedBorder:
            theme.inputDecorationTheme.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              borderSide: BorderSide(
                color: scheme.primary,
                width: AppSizes.borderWidthLg,
              ),
            ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: BorderSide(
            color: scheme.error,
            width: AppSizes.borderWidthSm,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: BorderSide(
            color: scheme.error,
            width: AppSizes.borderWidthLg,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lgMinus,
        ),
      ),
    );
  }
}
