import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const double fs10 = 10;
  static const double fs12 = 12;
  static const double fs13 = 13;
  static const double fs14 = 14;
  static const double fs16 = 16;
  static const double fs18 = 18;
  static const double fs20 = 18;
  static const double fs22 = 22;
  static const double fs24 = 24;
  static const double fs32 = 32;

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: fs24,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.0,
      ),
      titleMedium: TextStyle(
        fontSize: fs18,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.0,
      ),
      bodyLarge: TextStyle(
        fontSize: fs16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.0,
      ),
      bodyMedium: TextStyle(
        fontSize: fs14,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.0,
      ),
    );
  }
}
