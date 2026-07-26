import 'package:equatable/equatable.dart';

abstract class NotificationBadgeEvent extends Equatable {
  const NotificationBadgeEvent();

  @override
  List<Object?> get props => [];
}

class IncrementNotificationBadge extends NotificationBadgeEvent {
  const IncrementNotificationBadge();
}

class ClearNotificationBadge extends NotificationBadgeEvent {
  const ClearNotificationBadge();
}

class SetNotificationBadge extends NotificationBadgeEvent {
  const SetNotificationBadge(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}


class InitializeNotificationBadge
    extends NotificationBadgeEvent {
  const InitializeNotificationBadge();
}

class RefreshNotificationBadge
    extends NotificationBadgeEvent {

  const RefreshNotificationBadge();

}