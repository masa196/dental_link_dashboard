
import 'package:dental_link_dashboard/shared/dashboard_header/widgets/notification_bell.dart';
import 'package:flutter/material.dart';
import 'dashboard_search_bar.dart';
import 'widgets/header_container.dart';
import 'widgets/header_title.dart';
import 'widgets/menu_button.dart';
import 'widgets/profile_avatar.dart';

class TabletHeader extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final VoidCallback? onNotificationTap;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;
  final String title;
  final bool showSearchBar;
  final Widget? trailing;
  final int notificationCount;

  const TabletHeader({
    super.key,
    this.onSearch,
    this.onNotificationTap,
    required this.showMenuButton,
    this.onMenuPressed,
    required this.title,
    this.showSearchBar = true,
    this.trailing,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return HeaderContainer(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (showMenuButton) MenuButton(onPressed: onMenuPressed),

          Expanded(
            child: Row(
              children: [
                HeaderTitle(title: title),

                const Spacer(),

                if (showSearchBar) ...[
                  SizedBox(
                    width: 300,
                    child: DashboardSearchBar(onChanged: onSearch),
                  ),
                  const SizedBox(width: 12),
                ],

                if (trailing != null) ...[trailing!, const SizedBox(width: 16)],

               NotificationBell(
  onPressed: onNotificationTap,
),

                const SizedBox(width: 8),

                const ProfileAvatar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
