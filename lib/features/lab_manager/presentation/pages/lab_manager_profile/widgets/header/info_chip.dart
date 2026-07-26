import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {

  const InfoChip({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {


    final scheme =Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),

      decoration: BoxDecoration(
        color: backgroundColor ??scheme.secondary.withValues(alpha:0.18),

        borderRadius:BorderRadius.circular( AppRadius.pill, ),
      ),
      child: Text( text,
       style: TextStyle( 
        fontSize:12,
        fontWeight:FontWeight.w700,
          color:textColor ??  scheme.primary,
        ),
      ),
    );
  }
}