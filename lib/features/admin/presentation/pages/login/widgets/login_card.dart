import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key, required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(maxWidth: width),
      padding: AppSizes.cardPadding,
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: AppSizes.alpha98),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: AppSizes.alpha6),
          width: AppSizes.borderWidthThin,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: AppSizes.alpha28),
            blurRadius: AppSizes.loginCardShadowBlurLg,
            spreadRadius: AppSizes.loginCardShadowSpreadLg,
            offset: const Offset(0, AppSizes.loginCardShadowOffsetYLg),
          ),
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: AppSizes.alpha10),
            blurRadius: AppSizes.loginCardShadowBlurSm,
            spreadRadius: AppSizes.loginCardShadowSpreadSm,
            offset: const Offset(0, AppSizes.loginCardShadowOffsetYSm),
          ),
        ],
      ),
      child: child,
    );
  }
}
