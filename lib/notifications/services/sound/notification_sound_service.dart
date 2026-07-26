import 'dart:html' as html;

import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationSoundService {
  html.AudioElement? _audio;

  NotificationSoundService() {
    _audio = html.AudioElement('assets/sounds/notification.mp3')
      ..preload = 'auto';
  }

  Future<void> play() async {
    try {
      _audio?.currentTime = 0;
      await _audio?.play();
    } catch (_) {
      // تجاهل الأخطاء (مثل منع المتصفح للتشغيل التلقائي)
    }
  }
}