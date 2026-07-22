  import 'package:flutter/material.dart';

  import 'dashboard_search_bar.dart';
  import 'widgets/header_container.dart';
  import 'widgets/header_title.dart';
  import 'widgets/notification_button.dart';
  import 'widgets/profile_avatar.dart';

  class DesktopHeader extends StatelessWidget {
    final ValueChanged<String>? onSearch;
    final VoidCallback? onNotificationTap;
    final String title;
    final bool showSearchBar;
    final Widget? trailing;

    const DesktopHeader({
      super.key,
      this.onSearch,
      this.onNotificationTap,
      required this.title,
      this.showSearchBar = true,
      this.trailing,
    });

    @override
    Widget build(BuildContext context) {
      return HeaderContainer(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
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

                  NotificationButton(onPressed: onNotificationTap),

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
