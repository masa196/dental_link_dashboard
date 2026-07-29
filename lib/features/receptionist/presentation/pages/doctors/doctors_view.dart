import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_body.dart';
import 'package:dental_link_dashboard/notifications/presentation/widgets/notifications_dialog.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsView extends StatelessWidget {
  const DoctorsView({super.key, required this.mode});

  final DoctorsPageMode mode;

  static const double desktopWidth = 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewport) {
        final bool enableHorizontalScroll = viewport.maxWidth < desktopWidth;

        final bool enableVerticalScroll = viewport.maxHeight < 300;

        Widget body =  DoctorsBody(mode:mode);

        if (enableHorizontalScroll) {
          body = SizedBox(width: desktopWidth, child: body);

          body = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: body,
          );
        }

        final page = Column(
          children: [
            DashboardHeader(
              title: "متابعة الأطباء والديون",
              showMenuButton: !Responsive.isDesktop(context),
              notificationCount: 0,
              onNotificationTap: () {
                NotificationsDialog.show(context);
              },
              onSearch: (value) {
                context.read<ShowDoctorsBloc>().add(
                  ShowDoctorsRequested(page: 1, search: value),
                );
              },
            ),
            Expanded(child: SingleChildScrollView(child: body)),
          ],
        );

        if (!enableVerticalScroll) {
          return page;
        }

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewport.maxHeight),
            child: Column(
              children: [
                DashboardHeader(
                  title: "متابعة الأطباء والديون",
                  showMenuButton: !Responsive.isDesktop(context),
                  notificationCount: 0,
                  onNotificationTap: () {
                    NotificationsDialog.show(context);
                  },
                  onSearch: (value) {
                    context.read<ShowDoctorsBloc>().add(
                      ShowDoctorsRequested(page: 1, search: value),
                    );
                  },
                ),
                body,
              ],
            ),
          ),
        );
      },
    );
  }
}
