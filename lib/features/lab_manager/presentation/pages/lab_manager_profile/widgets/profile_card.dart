import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      padding: const EdgeInsets.all(28),

      decoration: BoxDecoration(
        color: scheme.surface,

        borderRadius: BorderRadius.circular(
          AppRadius.xl,
        ),

        border: Border.all(
          color: scheme.surfaceContainerHighest.withValues(
            alpha: 0.45,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(
              alpha: 0.10,
            ),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,

        children: [

          Row(
        
            children: [

              Container(
                width: 34,
                height: 34,

                decoration: BoxDecoration(
                  color: scheme.primary.withValues(
                    alpha: 0.10,
                  ),

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  icon,
                  size: 18,
                  color: scheme.primary,
                ),
              ),

              const SizedBox(
                width: AppSpacing.sm,
              ),

              Text(
                title,

                style: TextStyle(
                  fontSize: AppTypography.fs18,
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          child,
        ],
      ),
    );
  }
}