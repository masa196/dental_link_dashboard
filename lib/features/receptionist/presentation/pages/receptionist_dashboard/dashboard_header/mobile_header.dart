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

  const MobileHeader({
    super.key,
    this.onSearch,
    this.onNotificationTap,
    required this.showMenuButton,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return HeaderContainer(
      height: 120,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (showMenuButton)
                MenuButton(
                  onPressed: onMenuPressed,
                ),

              const SizedBox(width: 8),

              const Expanded(
                child: HeaderTitle(
                  title: "إدارة الطلبات",
                ),
              ),

              NotificationButton(
                onPressed: onNotificationTap,
              ),

              const SizedBox(width: 4),

              const ProfileAvatar(),
            ],
          ),

          const SizedBox(height: 12),

          DashboardSearchBar(
            onChanged: onSearch,
          ),
        ],
      ),
    );
  }
}