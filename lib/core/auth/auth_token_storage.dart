import 'package:dental_link_dashboard/core/auth/auth_sync_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';



class AuthTokenStorage {

    AuthTokenStorage(this._authSyncService);

  final AuthSyncService _authSyncService;

  static const String _boxName = 'auth_token_box';
  static const String _tokenKey = 'auth_token';

  late final Box<String> _box;

  Future<void> init() async {
    _box = await Hive.openBox<String>(_boxName);
    debugPrint('Got object store box in database $_boxName.');
  }

  String? get token => _box.get(_tokenKey);

  Future<void> saveToken(String token) async {
    await _box.put(_tokenKey, token);
  }

 Future<void> clearToken({
  bool notify = true,
}) async {

  debugPrint(
    '[TokenStorage] clearToken notify=$notify'
  );

  await _box.delete(_tokenKey);

  debugPrint(
    '[TokenStorage] token deleted'
  );

  if (notify) {
    debugPrint(
      '[TokenStorage] broadcasting logout'
    );

    _authSyncService.notifyLogout();
  }
}
  
}
