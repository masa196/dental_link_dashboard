import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';

class DarkThemeData {
  DarkThemeData._();

  static final ThemeData theme = _buildTheme();

  static ThemeData _buildTheme() {
    final ColorScheme scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppDarkColors.primary,
      onPrimary: AppDarkColors.onPrimary,
      secondary: AppDarkColors.secondary,
      onSecondary: AppDarkColors.onSecondary,
      surface: AppDarkColors.surface,
      onSurface: AppDarkColors.onSurface,
      error: AppDarkColors.alert,
      onError: AppDarkColors.onPrimary,
      outline: AppDarkColors.outline,
      tertiary: AppDarkColors.accent,
      onTertiary: AppDarkColors.onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppDarkColors.background,
      textTheme: AppTypography.textTheme(scheme.onSurface),
      cardColor: AppDarkColors.surface,
      dividerColor: AppDarkColors.divider,
      shadowColor: AppDarkColors.shadow,
      appBarTheme: AppBarTheme(
        backgroundColor: AppDarkColors.background,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppDarkColors.inputFill,
        hintStyle: TextStyle(color: AppDarkColors.hint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          borderSide: BorderSide(color: AppDarkColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          borderSide: BorderSide(
            color: AppDarkColors.outline,
            width: AppSizes.borderWidthSm,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.mdPlus),
          borderSide: BorderSide(
            color: scheme.secondary,
            width: AppSizes.borderWidthMd,
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
          foregroundColor: scheme.secondary,
          side: BorderSide(
            color: scheme.secondary.withValues(alpha: AppSizes.alpha5),
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
