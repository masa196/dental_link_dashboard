import 'package:flutter/material.dart';

import 'desktop_header.dart';
import 'mobile_header.dart';
import 'tablet_header.dart';

class DashboardHeader extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final VoidCallback? onNotificationTap;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;
  final String title;
  final bool showSearchBar;
   final Widget? trailing;


const DashboardHeader({
  super.key,
  required this.title,
  this.onSearch,
  this.onNotificationTap,
  this.showMenuButton = false,
  this.onMenuPressed,
  this.showSearchBar = true,
   this.trailing,
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
            title: title,
            showSearchBar: showSearchBar,
            trailing: trailing,
          );
        }

        if (width >= 700) {
          return TabletHeader(
            onSearch: onSearch,
            onNotificationTap: onNotificationTap,
            showMenuButton: showMenuButton,
            onMenuPressed: onMenuPressed,
            title: title,
            showSearchBar: showSearchBar,
             trailing: trailing,
          );
        }

        return MobileHeader(
          onSearch: onSearch,
          onNotificationTap: onNotificationTap,
          showMenuButton: showMenuButton,
          onMenuPressed: onMenuPressed,
          title: title,
          showSearchBar: showSearchBar,
           trailing: trailing,
        );
      },
    );
  }
}