import 'package:equatable/equatable.dart';

import '../../../domain/entities/show_notifications_entity.dart';


class ShowNotificationsState extends Equatable {

  const ShowNotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.failureMessage,
  });


  final List<NotificationEntity> notifications;
  final bool isLoading;
  final bool isRefreshing;
  final String? failureMessage;



  ShowNotificationsState copyWith({
    List<NotificationEntity>? notifications,
    bool? isLoading,
    bool? isRefreshing,
    String? failureMessage,
  }) {

    return ShowNotificationsState(

      notifications:
          notifications ?? this.notifications,

      isLoading:
          isLoading ?? this.isLoading,

      isRefreshing:
          isRefreshing ?? this.isRefreshing,

      failureMessage:
          failureMessage,

    );

  }



  @override
  List<Object?> get props => [
    notifications,
    isLoading,
    isRefreshing,
    failureMessage,
  ];

}