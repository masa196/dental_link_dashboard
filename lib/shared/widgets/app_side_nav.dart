import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/l10n/locale_cubit.dart';
import 'package:dental_link_dashboard/core/constants/theme_data/theme_cubit.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_event.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class AppSideNav extends StatelessWidget {
  const AppSideNav({super.key, this.compact = true, this.width});

  final bool compact;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isArabic = context.isArabic;
    final isDark = context.isDark;

    final location = GoRouterState.of(context).uri.path;

    return Container(
      width:
          width ??
          (compact ? AppSizes.sideNavWidthCompact : AppSizes.sideNavWidth),
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.sm),

            /// --- Primary Items ---
            _NavItem(
              icon: Icons.account_circle,
              label: l10n.navProfile,
              active: location == '/profile',
              compact: compact,
              onTap: () => const ProfileRoute().go(context),
            ),

            _NavItem(
              icon: Icons.dashboard_customize,
              label: l10n.navDashboard,
              active: location.startsWith('/manage-labs'),
              compact: compact,
              onTap: () => const ManageLabsRoute().go(context),
            ),

            _NavItem(
              icon: Icons.manage_accounts,
              label: l10n.navDashboard,
              active: location.startsWith('/roles_management'),
              compact: compact,
              onTap: () => const RolesSystemManagementRoute().go(context),
            ),

            _NavItem(
              icon: Icons.group_outlined,
              label: l10n.navTeams,
              compact: compact,
            ),

            _NavItem(
              icon: Icons.sell_outlined,
              label: l10n.navSales,
              compact: compact,
            ),

            _NavItem(
              icon: Icons.settings,
              label: l10n.navSettings,
              compact: compact,
            ),

            const Spacer(),

            /// --- Footer ---
            _NavItem(
              icon: Icons.help_outline,
              label: l10n.navHelp,
              compact: compact,
            ),

            _NavItem(
              icon: Icons.logout,
              label: l10n.navLogout,
              compact: compact,
              onTap: () {
                _handleLogout(context);
              },
            ),

            const SizedBox(height: AppSpacing.md),

            compact
                ? Column(
                    children: [
                      IconButton(
                        onPressed: () => context.read<LocaleCubit>().toggle(),
                        icon: const Icon(Icons.language),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      IconButton(
                        onPressed: () => context.read<ThemeCubit>().toggle(),
                        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  )
                : _ThemeSwitches(isArabic: isArabic, isDark: isDark),

            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final token = locator<AuthTokenStorage>().token;
    final router = GoRouter.of(context);

    if (token == null || token.isEmpty) {
      AppSnackbarHelper.showFailure(
        context,
        title: context.l10n.error,
        message: '${context.l10n.navLogout} failed: no token',
      );
      return;
    }

    final bloc = locator<LogoutBloc>();

    late final StreamSubscription sub;
    sub = bloc.stream.listen((state) async {
      if (state.isSuccess) {
        await locator<AuthTokenStorage>().clearToken();
        AppSnackbarHelper.showSuccess(
          context,
          title: context.l10n.success,
          message: state.response?.message ?? 'Logged out',
        );
        router.go('/login');
        await sub.cancel();
        await bloc.close();
      }

      if (state.isFailure) {
        AppSnackbarHelper.showFailure(
          context,
          title: context.l10n.error,
          message: state.failure?.message ?? 'Logout failed',
          failure: state.failure,
        );
        await sub.cancel();
        await bloc.close();
      }
    });

    bloc.add(LogoutRequested(token));
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.compact = true,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (compact) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: AppSizes.sideNavIconBox / 2,
            backgroundColor: active
                ? colorScheme.secondary
                : Colors.transparent,
            child: Icon(
              icon,
              color: colorScheme.onPrimary,
              size: AppSizes.sideNavIconSize,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mdMinus,
        vertical: 4,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Container(
          height: AppSizes.sideNavItemHeight,
          decoration: BoxDecoration(
            color: active ? colorScheme.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              const SizedBox(width: AppSpacing.sm),
              Icon(
                icon,
                color: colorScheme.onPrimary,
                size: AppSizes.sideNavIconSize,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeSwitches extends StatelessWidget {
  const _ThemeSwitches({required this.isArabic, required this.isDark});

  final bool isArabic;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = Theme.of(context).colorScheme.onPrimary;

    return Column(
      children: [
        SwitchListTile(
          value: isArabic,
          onChanged: (_) => context.read<LocaleCubit>().toggle(),
          title: Text(l10n.switchLanguage, style: TextStyle(color: color)),
        ),
        SwitchListTile(
          value: isDark,
          onChanged: (_) => context.read<ThemeCubit>().toggle(),
          title: Text(l10n.switchTheme, style: TextStyle(color: color)),
        ),
      ],
    );
  }
}
