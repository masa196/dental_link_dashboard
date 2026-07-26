import 'package:dental_link_dashboard/notifications/domain/entities/show_notifications_entity.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.notifications)),
      title: Text(
        notification.data.message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(height: 1.6, fontWeight: FontWeight.w300),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 10),

          Text(
            formatNotificationDate(notification.createdAt),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  String formatNotificationDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
