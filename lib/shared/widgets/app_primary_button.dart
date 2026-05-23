import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = AppSpacing.inputHeight,
    this.backgroundColor,
    this.borderRadius = AppRadius.lg,
    this.textStyle,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final Color? backgroundColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor =
        backgroundColor ?? Theme.of(context).primaryColor;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedColor,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: AppSizes.buttonElevation,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                ),
              )
            : Text(
                text,
                style:
                    textStyle ??
                    TextStyle(
                      fontSize: AppTypography.fs16,
                      fontWeight: FontWeight.w600,
                      color: onPrimary,
                    ),
              ),
      ),
    );
  }
}
