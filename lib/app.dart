import 'package:dental_link_dashboard/core/auth/auth_session_listener.dart';
import 'package:dental_link_dashboard/notifications/presentation/bloc/notification_badge/notification_badge_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/auth/user_role_cubit.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';
import 'package:dental_link_dashboard/l10n/locale_cubit.dart';
import 'package:dental_link_dashboard/core/constants/theme_data/theme_cubit.dart';
import 'package:dental_link_dashboard/core/constants/theme_data/theme_data_dark.dart';
import 'package:dental_link_dashboard/core/constants/theme_data/theme_data_light.dart';

class DentalLinkDashboardApp extends StatelessWidget {
  const DentalLinkDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<LocaleCubit>()),
        BlocProvider.value(value: locator<ThemeCubit>()),
        BlocProvider.value(value: locator<UserRoleCubit>()),

        BlocProvider(
          create: (_) => locator<NotificationBadgeBloc>(),
          //  ..add(const InitializeNotificationBadge()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              return AuthSessionListener(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  locale: locale,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  theme: LightThemeData.theme,
                  darkTheme: DarkThemeData.theme,
                  themeMode: mode,
                  routerConfig: AppRouter.config,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
