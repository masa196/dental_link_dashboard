import 'package:flutter/material.dart';

import 'desktop_header.dart';
import 'mobile_header.dart';
import 'tablet_header.dart';

class DashboardHeader extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final VoidCallback? onNotificationTap;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  const DashboardHeader({
    super.key,
    this.onSearch,
    this.onNotificationTap,
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= 1200) {
          return DesktopHeader(
            onSearch: onSearch,
            onNotificationTap: onNotificationTap,
          );
        }

        if (width >= 700) {
          return TabletHeader(
            onSearch: onSearch,
            onNotificationTap: onNotificationTap,
            showMenuButton: showMenuButton,
            onMenuPressed: onMenuPressed,
          );
        }

        return MobileHeader(
          onSearch: onSearch,
          onNotificationTap: onNotificationTap,
          showMenuButton: showMenuButton,
          onMenuPressed: onMenuPressed,
        );
      },
    );
  }
}