import 'dart:async';

import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/auth/user_role_cubit.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/theme_data/theme_cubit.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:dental_link_dashboard/l10n/locale_cubit.dart';

class LabManagerSideNav extends StatelessWidget {
  const LabManagerSideNav({super.key, this.compact = true, this.width});

  final bool compact;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isArabic = context.isArabic;
    final isDark = context.isDark;

    final location = GoRouterState.of(context).uri.path;

    final sideWidth =
        width ??
        (compact ? AppSizes.sideNavWidthCompact : AppSizes.sideNavWidth);

    return Container(
      width: sideWidth,
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        top: false,

        // ✅ الحل: Scroll-aware Column بدون تغيير UI
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      _NavItem(
                        icon: Icons.dashboard_customize,
                        label: l10n.navDashboard,
                        active: location == '/lab-manager',
                        compact: compact,
                        onTap: () =>
                            const LabManagerDashboardRoute().go(context),
                      ),

                      _NavItem(
                        icon: Icons.monitor_heart_outlined,
                        label: isArabic ? 'الطلبات' : 'Orders',
                        active: location.startsWith('/lab-manager/orders'),
                        compact: compact,
                       onTap: () => const LabManagerOrdersRoute().go(context),
                      ),

                      _NavItem(
                        icon: Icons.people_outlined,
                        label: isArabic ? 'المواد والأسعار' : 'materials & Prices',
                        active: location.startsWith('/lab-manager/materials'),
                        compact: compact,
                        onTap: () =>
                            const LabManagerMaterialsRoute().go(context),
                      ),

                      _NavItem(
                        icon: Icons.badge_outlined,
                        label: isArabic ? 'الموظفون' : 'Staff',
                        active: location.startsWith('/lab-manager/employees'),
                        compact: compact,
                        onTap: () =>
                            const LabManagerEmployeesRoute().go(context),
                      ),

                      _NavItem(
                        icon: Icons.description_outlined,
                        label: isArabic ? 'إدارة الأدوار' : 'Roles Management',
                        active: location.startsWith('/lab-manager/roles'),
                        compact: compact,
                        onTap: () => const RolesManagementRoute().go(context),
                      ),

                      const Spacer(),

                      _NavItem(
                        icon: Icons.help_outline,
                        label: l10n.navHelp,
                        compact: compact,
                      ),

                      _NavItem(
                        icon: Icons.logout,
                        label: l10n.navLogout,
                        compact: compact,
                        onTap: () => _handleLogout(context),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      compact
                          ? Column(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      context.read<LocaleCubit>().toggle(),
                                  icon: const Icon(Icons.language),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                                IconButton(
                                  onPressed: () =>
                                      context.read<ThemeCubit>().toggle(),
                                  icon: Icon(
                                    isDark ? Icons.light_mode : Icons.dark_mode,
                                  ),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ],
                            )
                          : _ThemeSwitches(isArabic: isArabic, isDark: isDark),

                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ),
                ),
              ),
            );
          },
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
        locator<UserRoleCubit>().clearUserRole();

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

class _NavItem extends StatefulWidget {
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
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final hoverColor = colorScheme.onPrimary.withValues(alpha: 0.08);

    final backgroundColor = widget.active
        ? colorScheme.secondary
        : (_hover ? hoverColor : Colors.transparent);

    Widget child;

    if (widget.compact) {
      child = Tooltip(
        message: widget.label, // 👈 اسم الصفحة يظهر عند hover
        waitDuration: const Duration(milliseconds: 300),
        child: CircleAvatar(
          radius: AppSizes.sideNavIconBox / 2,
          backgroundColor: backgroundColor,
          child: Icon(
            widget.icon,
            color: colorScheme.onPrimary,
            size: AppSizes.sideNavIconSize,
          ),
        ),
      );
    } else {
      child = Container(
        height: AppSizes.sideNavItemHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.sm),
            Icon(
              widget.icon,
              color: colorScheme.onPrimary,
              size: AppSizes.sideNavIconSize,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: widget.active
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: child,
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
