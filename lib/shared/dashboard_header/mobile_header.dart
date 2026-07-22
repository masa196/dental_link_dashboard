import 'package:flutter/material.dart';

import 'dashboard_search_bar.dart';
import 'widgets/header_container.dart';
import 'widgets/header_title.dart';
import 'widgets/menu_button.dart';
import 'widgets/notification_button.dart';
import 'widgets/profile_avatar.dart';

class MobileHeader extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final VoidCallback? onNotificationTap;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;
  final String title;
  final bool showSearchBar;
  final Widget? trailing;

  const MobileHeader({
    super.key,
    this.onSearch,
    this.onNotificationTap,
    required this.showMenuButton,
    this.onMenuPressed,
    required this.title,
    this.showSearchBar = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return HeaderContainer(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              if (showMenuButton) MenuButton(onPressed: onMenuPressed),

              const SizedBox(width: 8),

              Expanded(
                child: Row(
                  children: [
                    Expanded(child: HeaderTitle(title: title)),

                    if (trailing != null) ...[
                      const SizedBox(width: 8),
                      trailing!,
                    ],
                  ],
                ),
              ),

              NotificationButton(onPressed: onNotificationTap),

              const SizedBox(width: 4),

              const ProfileAvatar(),
            ],
          ),

          if (showSearchBar) ...[
            SizedBox(
              width: 220,
              child: DashboardSearchBar(onChanged: onSearch),
            ),
            const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}
