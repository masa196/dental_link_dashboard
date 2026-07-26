import 'dart:developer';

import 'package:dental_link_dashboard/core/config/firebase_config.dart';
import 'package:dental_link_dashboard/notifications/services/notification_event_bus.dart';
import 'package:dental_link_dashboard/notifications/services/overlay/overlay_service.dart';
import 'package:dental_link_dashboard/notifications/services/sound/notification_sound_service.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseMessagingService {
  FirebaseMessagingService(
  this.notificationEventBus,
  this.overlayService,
  this.notificationSoundService,
);

  final NotificationSoundService notificationSoundService;
  final NotificationEventBus notificationEventBus;
  final OverlayService overlayService;
  bool _isListening = false;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
  final settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  log(
    'Notification permission: ${settings.authorizationStatus}',
    name: 'FirebaseMessaging',
  );
}

void startListening() {
  if (_isListening) return;

  _isListening = true;

  FirebaseMessaging.onMessage.listen(_onForegroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
}

  Future<String?> getToken() async {
    final token = await _messaging.getToken(vapidKey: FirebaseConfig.vapidKey);

    log('FCM Token: $token', name: 'FirebaseMessaging');

    return token;
  }

  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('========== FCM RECEIVED ==========');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Data: ${message.data}');

    //notificationEventBus.notify();

    overlayService.show(
      title: message.data['priority'] ?? "New Notification",
      body: message.notification?.body ?? '',
    );

    notificationSoundService.play();
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    log('Notification opened', name: 'FirebaseMessaging');

   // notificationEventBus.notify();
  }
}
