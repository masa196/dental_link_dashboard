import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/notifications/presentation/bloc/show_notifications/show_notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';

import 'package:dental_link_dashboard/shared/widgets/app_side_nav_lab_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabManagerLayout extends StatefulWidget {
  final Widget child;

  const LabManagerLayout({super.key, required this.child});

  @override
  State<LabManagerLayout> createState() => _LabManagerLayoutState();
}

class _LabManagerLayoutState extends State<LabManagerLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
Widget build(BuildContext context) {
  final isDesktop = Responsive.isDesktop(context);

  return BlocProvider(
    create: (_) => locator<ShowNotificationsBloc>(),

    child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      drawer: isDesktop
          ? null
          : Drawer(
              child: SafeArea(
                child: LabManagerSideNav(
                  compact: false,
                  width: AppSizes.sideNavDrawerWidth,
                ),
              ),
            ),

      body: Row(
        children: [
          if (isDesktop)
            const LabManagerSideNav(
              compact: true,
              width: AppSizes.sideNavWidthCompact,
            ),

          Expanded(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? AppSpacing.lg : AppSpacing.md,
                  vertical: AppSpacing.md,
                ),

                child: LayoutScope(
                  openDrawer: openDrawer,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}

/// يمرر function للصفحات
class LayoutScope extends InheritedWidget {
  final VoidCallback openDrawer;

  const LayoutScope({
    super.key,
    required this.openDrawer,
    required super.child,
  });

  static LayoutScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LayoutScope>();

    assert(scope != null, 'LayoutScope not found in widget tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(LayoutScope oldWidget) => false;
}
