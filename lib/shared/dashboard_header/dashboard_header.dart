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
   final int notificationCount;
   final bool showNotification;


const DashboardHeader({
  super.key,
  required this.title,
  this.onSearch,
  this.onNotificationTap,
  this.showMenuButton = false,
  this.onMenuPressed,
  this.showSearchBar = true,
  this.showNotification = true,
   this.trailing,
   this.notificationCount = 0,
});

  @override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;

      Widget header;

      if (width >= 1200) {
        header = DesktopHeader(
          onSearch: onSearch,
          onNotificationTap: onNotificationTap,
          title: title,
          showSearchBar: showSearchBar,
          trailing: trailing,
          notificationCount: notificationCount,
           showNotification: showNotification,
        );
      } else if (width >= 700) {
        header = TabletHeader(
          onSearch: onSearch,
          onNotificationTap: onNotificationTap,
          showMenuButton: showMenuButton,
          onMenuPressed: onMenuPressed,
          title: title,
          showSearchBar: showSearchBar,
          trailing: trailing,
          notificationCount: notificationCount,
           showNotification: showNotification,
        );
      } else {
        header = MobileHeader(
          onSearch: onSearch,
          onNotificationTap: onNotificationTap,
          showMenuButton: showMenuButton,
          onMenuPressed: onMenuPressed,
          title: title,
          showSearchBar: showSearchBar,
          trailing: trailing,
          notificationCount: notificationCount,
           showNotification: showNotification,
        );
      }


      if(width < 350){
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 350,
            child: header,
          ),
        );
      }

      return header;
    },
  );
}
}