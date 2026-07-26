import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/notifications/presentation/bloc/show_notifications/show_notifications_bloc.dart';

import 'package:dental_link_dashboard/notifications/services/overlay/overlay_service.dart';
import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/shared/widgets/app_side_nav_receptionist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/// تخطيط صفحات موظف الاستقبال
class ReceptionistLayout extends StatefulWidget {
  final Widget child;

  const ReceptionistLayout({super.key, required this.child});

  @override
  State<ReceptionistLayout> createState() => _ReceptionistLayoutState();
}

class _ReceptionistLayoutState extends State<ReceptionistLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  
  

 @override
void initState() {
  super.initState();
}

  bool _attached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_attached) return;

    locator<OverlayService>().attach(context);

    _attached = true;
  }

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
                child: ReceptionistSideNav(
                  compact: false,
                  width: AppSizes.sideNavDrawerWidth,
                ),
              ),
            ),

      body: Row(
        children: [
          if (isDesktop)
            const ReceptionistSideNav(
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
                child: ReceptionistLayoutScope(
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

class ReceptionistLayoutScope extends InheritedWidget {
  final VoidCallback openDrawer;

  const ReceptionistLayoutScope({
    super.key,
    required this.openDrawer,
    required super.child,
  });

  static ReceptionistLayoutScope of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<ReceptionistLayoutScope>();

    assert(scope != null, 'ReceptionistLayoutScope not found');

    return scope!;
  }

  @override
  bool updateShouldNotify(ReceptionistLayoutScope oldWidget) => false;
}
