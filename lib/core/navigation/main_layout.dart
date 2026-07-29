import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/shared/widgets/app_side_nav.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      drawer: isDesktop
          ? null
          : Drawer(
              child: SafeArea(
                child: AppSideNav(
                  compact: false,
                  width: AppSizes.sideNavDrawerWidth,
                ),
              ),
            ),

      body: Row(
        children: [
          if (isDesktop)
            const AppSideNav(
              compact: true,
              width: AppSizes.sideNavWidthCompact,
            ),

          Expanded(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      isDesktop ? AppSpacing.lg : AppSpacing.md,
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
    );
  }
}



class LayoutScope extends InheritedWidget {
  final VoidCallback openDrawer;

  const LayoutScope({
    super.key,
    required this.openDrawer,
    required super.child,
  });

  static LayoutScope of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<LayoutScope>();

    assert(scope != null, 'LayoutScope not found');

    return scope!;
  }

  @override
  bool updateShouldNotify(LayoutScope oldWidget) => false;
}
