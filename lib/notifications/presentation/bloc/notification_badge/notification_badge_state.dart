import 'package:equatable/equatable.dart';

class NotificationBadgeState extends Equatable {
  const NotificationBadgeState({
    this.unreadCount = 0,
  });

  final int unreadCount;

  NotificationBadgeState copyWith({
    int? unreadCount,
  }) {
    return NotificationBadgeState(
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
        unreadCount,
      ];
}