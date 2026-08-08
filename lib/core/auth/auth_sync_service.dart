import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthSyncService {
  AuthSyncService() {
    _channel = BroadcastChannel(_channelName);
    debugPrint(
    '[AuthSync] BroadcastChannel created | instance=$_instanceId',
  );
  }

  static const _channelName = 'auth_channel';

  final String _instanceId =
      DateTime.now().microsecondsSinceEpoch.toString();

  late final BroadcastChannel _channel;

  Stream<void> get onLogout => _channel.onMessage
    .where((event) {
      final data = event.data;

      debugPrint(
        '[AuthSync] message=$data'
      );

      if (data is! String) {
        return false;
      }

      if (!data.startsWith('logout:')) {
        return false;
      }

      final sender =
          data.substring('logout:'.length);

      return sender != _instanceId;
    })
    .map((_) {});

  void notifyLogout() {
     debugPrint(
    '[AuthSync] Sending logout broadcast | sender=$_instanceId',
  );
    _channel.postMessage(
  'logout:$_instanceId',
);
  }

  void dispose() {
    _channel.close();
  }
}