import 'dart:async';

import 'package:dental_link_dashboard/notifications/services/badge/badge_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

//import '../../../services/notification_event_bus.dart';
import 'notification_badge_event.dart';
import 'notification_badge_state.dart';

@injectable
class NotificationBadgeBloc
    extends Bloc<NotificationBadgeEvent, NotificationBadgeState> {
  NotificationBadgeBloc( this.badgeStorageService)
    : super(const NotificationBadgeState()) {
        print("NotificationBadgeBloc hashCode = $hashCode");
    on<InitializeNotificationBadge>(_initialize);
    on<RefreshNotificationBadge>(_refresh);
    on<IncrementNotificationBadge>(_increment);
    on<ClearNotificationBadge>(_clear);
    on<SetNotificationBadge>(_set);

    /*

    _subscription = notificationEventBus.stream.listen((_) {
      add(const IncrementNotificationBadge());
    });
    */
  }

 // final NotificationEventBus notificationEventBus;
  final BadgeStorageService badgeStorageService;

  late final StreamSubscription<void> _subscription;

  Future<void> _increment(
    IncrementNotificationBadge event,
    Emitter<NotificationBadgeState> emit,
  ) async {
    final current = await badgeStorageService.getCount();

    final next = current + 1;

    await badgeStorageService.setCount(next);

    emit(state.copyWith(unreadCount: next));
  }

  Future<void> _set(
    SetNotificationBadge event,
    Emitter<NotificationBadgeState> emit,
  ) async {
    await badgeStorageService.setCount(event.count);

    emit(state.copyWith(unreadCount: event.count));
  }

  Future<void> _clear(
    ClearNotificationBadge event,
    Emitter<NotificationBadgeState> emit,
  ) async {
    await badgeStorageService.clear();

    emit(state.copyWith(unreadCount: 0));
  }

  Future<void> _initialize(
    InitializeNotificationBadge event,
    Emitter<NotificationBadgeState> emit,
  ) async {
    final count = await badgeStorageService.getCount();

    print("IndexedDB Count = $count");

    emit(state.copyWith(unreadCount: count));
  }

Future<void> _refresh(
  RefreshNotificationBadge event,
  Emitter<NotificationBadgeState> emit,
) async {
  final count = await badgeStorageService.getCount();

  print("Refresh Badge Count = $count");
  print("Before emit = ${state.unreadCount}");

  emit(
    state.copyWith(
      unreadCount: count,
    ),
  );

  print("After emit = $count");
}

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
