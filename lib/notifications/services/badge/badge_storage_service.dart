//badge_storage_service.dart

abstract interface class BadgeStorageService {
  Future<int> getCount();

  Future<void> setCount(int value);

  Future<void> clear();
}