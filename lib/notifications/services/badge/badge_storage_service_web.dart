
//badge_storage_service_web.dart

import 'package:idb_shim/idb_browser.dart';
import 'package:injectable/injectable.dart';

import 'badge_storage_service.dart';

const _dbName = 'dental_link_notifications';
const _storeName = 'badge';
const _key = 'count';

@LazySingleton(as: BadgeStorageService)
class BadgeStorageServiceWeb implements BadgeStorageService {
  final IdbFactory _factory = getIdbFactory()!;

  Future<Database> _openDatabase() async {
    return _factory.open(
      _dbName,
      version: 1,
      onUpgradeNeeded: (VersionChangeEvent event) {
        final db = event.database;

        if (!db.objectStoreNames.contains(_storeName)) {
          db.createObjectStore(_storeName);
        }
      },
    );
  }

  @override
  Future<int> getCount() async {
    final db = await _openDatabase();

    final txn = db.transaction(_storeName, idbModeReadOnly);

    final store = txn.objectStore(_storeName);

    final value = await store.getObject(_key);

    await txn.completed;

    db.close();

    return (value as int?) ?? 0;
  }

  @override
  Future<void> setCount(int value) async {
    final db = await _openDatabase();

    final txn = db.transaction(_storeName, idbModeReadWrite);

    await txn.objectStore(_storeName).put(value, _key);

    await txn.completed;

    db.close();
  }

  @override
  Future<void> clear() async {
    await setCount(0);
  }
}