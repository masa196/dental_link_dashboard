import 'package:dental_link_dashboard/notifications/presentation/bloc/notification_badge/notification_badge_bloc.dart';
import 'package:dental_link_dashboard/notifications/presentation/bloc/notification_badge/notification_badge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_button.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBadgeBloc, NotificationBadgeState>(
  builder: (context, state) {
    print("NotificationBell rebuild => ${state.unreadCount}");

    return NotificationButton(
      count: state.unreadCount,
      onPressed: onPressed,
    );
  },
);
  }
}