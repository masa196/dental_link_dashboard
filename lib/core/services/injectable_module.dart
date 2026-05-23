
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';

@module
abstract class InjectableModule {
  @preResolve
  @singleton
  Future<AuthTokenStorage> get authTokenStorage async {
    final storage = AuthTokenStorage();

    await storage.init();

    return storage;
  }
}

