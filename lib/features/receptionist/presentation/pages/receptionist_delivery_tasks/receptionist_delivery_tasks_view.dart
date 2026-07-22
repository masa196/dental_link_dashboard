import 'package:dental_link_dashboard/core/navigation/receptionist_layout.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_state.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/pagination/floating_pagination.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/widgets/delivery_tasks_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionistDeliveryTasksView extends StatelessWidget {
  const ReceptionistDeliveryTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ================= HEADER =================
        DashboardHeader(
          title: "مهام التوصيل",
          showMenuButton: !Responsive.isDesktop(context),
          onMenuPressed: ReceptionistLayoutScope.of(context).openDrawer,
          onSearch: (_) {},
          onNotificationTap: () {},
        ),

        /// ================= BODY =================
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),

                child: Column(
                  children: [
                    /// ================= LIST =================
                    const Expanded(child: ClipRect(child: DeliveryTasksList())),

                    const SizedBox(height: 12),

                    /// ================= PAGINATION SAFE AREA =================
                    BlocBuilder<ShowDeliveryTasksBloc, ShowDeliveryTasksState>(
                      builder: (context, state) {
                        if (state.lastPage <= 1) {
                          return const SizedBox.shrink();
                        }

                        return LayoutBuilder(
                          builder: (context, paginationConstraints) {
                            final isSmall =
                                paginationConstraints.maxWidth < 420;

                            return Align(
                              alignment: Alignment.center,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 650,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: SizedBox(
                                    height: 40,
                                    child: FloatingPagination(
                                      compact: isSmall,
                                      currentPage: state.currentPage,
                                      totalPages: state.lastPage,
                                      onPageChanged: (page) {
                                        context
                                            .read<ShowDeliveryTasksBloc>()
                                            .add(
                                              ShowDeliveryTasksRequested(
                                                page: page,
                                                search: state.currentSearch,
                                              ),
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
