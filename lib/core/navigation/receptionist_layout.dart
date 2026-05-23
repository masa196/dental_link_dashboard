import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/shared/widgets/app_side_nav_receptionist.dart';

/// تخطيط صفحات موظف الاستقبال
class ReceptionistLayout extends StatelessWidget {
  final Widget child;

  const ReceptionistLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: isDesktop
          ? null
          : Drawer(
              child: SafeArea(
                child: ReceptionistSideNav(
                  compact: false,
                  width: AppSizes.sideNavDrawerWidth,
                ),
              ),
            ),
      body: Row(
        children: [
          if (isDesktop)
            const ReceptionistSideNav(
              compact: true,
              width: AppSizes.sideNavWidthCompact,
            ),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? AppSpacing.lg : AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
