import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';

class LightThemeData {
  LightThemeData._();

  static final ThemeData theme = _buildTheme();

  static ThemeData _buildTheme() {
    final ColorScheme scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppLightColors.primary,
      onPrimary: AppLightColors.onPrimary,
      secondary: AppLightColors.secondary,
      onSecondary: AppLightColors.onSecondary,
      surface: AppLightColors.surface,
      onSurface: AppLightColors.onSurface,
      error: AppLightColors.alert,
      onError: AppLightColors.onPrimary,
      outline: AppLightColors.outline,
      tertiary: AppLightColors.accent,
      onTertiary: AppLightColors.onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppLightColors.background,
      textTheme: AppTypography.textTheme(scheme.onSurface),
      cardColor: AppLightColors.surface,
      dividerColor: AppLightColors.divider,
      shadowColor: AppLightColors.shadow,
      appBarTheme: AppBarTheme(
        backgroundColor: AppLightColors.background,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppLightColors.inputFill,
        hintStyle: TextStyle(color: AppLightColors.hint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          borderSide: BorderSide(color: AppLightColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          borderSide: BorderSide(
            color: AppLightColors.outline,
            width: AppSizes.borderWidthSm,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          borderSide: BorderSide(
            color: scheme.primary,
            width: AppSizes.borderWidthLg,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(
            color: scheme.primary.withValues(alpha: AppSizes.alpha35),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          ),
        ),
      ),
    );
  }
}
