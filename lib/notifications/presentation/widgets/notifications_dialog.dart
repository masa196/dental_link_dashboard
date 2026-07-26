import 'package:dental_link_dashboard/notifications/presentation/bloc/show_notifications/show_notifications_bloc.dart';
import 'package:dental_link_dashboard/notifications/presentation/bloc/show_notifications/show_notifications_event.dart';
import 'package:dental_link_dashboard/notifications/presentation/bloc/show_notifications/show_notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_tile.dart';

class NotificationsDialog extends StatelessWidget {
  const NotificationsDialog({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = context.read<ShowNotificationsBloc>();

    return showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: bloc..add(const ShowNotificationsRequested()),
          child: const NotificationsDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: SizedBox(
        width: 450,
        height: 550,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    "الإشعارات",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),

              Expanded(
                child:
                    BlocBuilder<ShowNotificationsBloc, ShowNotificationsState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.failureMessage != null) {
                          return Center(child: Text(state.failureMessage!));
                        }
                        if (state.notifications.isEmpty) {
                          return const Center(child: Text("لا يوجد إشعارات"));
                        }
                        return ListView.separated(
                          itemCount: state.notifications.length,

                          separatorBuilder: (_, __) => const Divider(),

                          itemBuilder: (context, index) {
                            final notification = state.notifications[index];

                            return NotificationTile(notification: notification);
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
