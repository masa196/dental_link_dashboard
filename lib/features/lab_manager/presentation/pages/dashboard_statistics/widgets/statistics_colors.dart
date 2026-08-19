import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';

class StatisticsColors {
  StatisticsColors._();

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color primary(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.primary
        : AppLightColors.primary;
  }

  static Color secondary(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.secondary
        : AppLightColors.secondary;
  }

  static Color accent(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.accent
        : AppLightColors.accent;
  }

  static Color success(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.success
        : AppLightColors.success;
  }

  static Color alert(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.alert
        : AppLightColors.alert;
  }

  static Color textPrimary(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.onSurface
        : AppLightColors.onSurface;
  }

  static Color textSecondary(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.textSecondary
        : AppLightColors.textSecondary;
  }

  static Color hint(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.hint
        : AppLightColors.hint;
  }

  static Color surface(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.surface
        : AppLightColors.surface;
  }

  static Color background(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.background
        : AppLightColors.background;
  }

  static Color divider(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.divider
        : AppLightColors.divider;
  }

  static Color outline(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.outline
        : AppLightColors.outline;
  }

  static Color chartGrid(BuildContext context) {
    return isDark(context)
        ? AppDarkColors.divider
        : AppLightColors.divider;
  }

  static List<Color> technicianColors(BuildContext context) {
    return [
      primary(context),
      accent(context),
      secondary(context),
      success(context),
      isDark(context)
          ? AppDarkColors.infoStrong
          : AppLightColors.infoStrong,
    ];
  }
}