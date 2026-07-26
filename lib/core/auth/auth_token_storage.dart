import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';



class AuthTokenStorage {
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

  Future<void> clearToken() async {
    await _box.delete(_tokenKey);
  }
}
