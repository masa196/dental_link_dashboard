import 'dart:async';

import 'package:dental_link_dashboard/core/auth/auth_sync_service.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/auth/user_role_cubit.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:flutter/material.dart';

class AuthSessionListener extends StatefulWidget {
  const AuthSessionListener({super.key, required this.child});

  final Widget child;

  @override
  State<AuthSessionListener> createState() => _AuthSessionListenerState();
}

class _AuthSessionListenerState extends State<AuthSessionListener> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
     debugPrint('[SessionListener] initState');

    _subscription = locator<AuthSyncService>().onLogout.listen(_onLogout);
  }

 Future<void> _onLogout(_) async {

  debugPrint(
    '[SessionListener] Logout event received'
  );

  await locator<AuthTokenStorage>()
      .clearToken(notify: false);

  debugPrint(
    '[SessionListener] Token cleared'
  );

  locator<UserRoleCubit>().clearUserRole();

  debugPrint(
    '[SessionListener] Role cleared'
  );

  if (!mounted) return;

  debugPrint(
    '[SessionListener] Navigating to login'
  );

  AppRouter.config.go('/login');
}

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
