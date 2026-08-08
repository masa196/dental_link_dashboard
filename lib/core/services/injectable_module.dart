
import 'package:dental_link_dashboard/core/auth/auth_sync_service.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';

@module
abstract class InjectableModule {
  @preResolve
  @singleton
  Future<AuthTokenStorage> authTokenStorage(
    AuthSyncService authSyncService,
  ) async {
    final storage = AuthTokenStorage(authSyncService);
    await storage.init();
    return storage;
  }
}

