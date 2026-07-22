// ignore_for_file: deprecated_member_use

import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/attachments/attachments_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/notes_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/order_details_layout.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/order_summary_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/patient_info_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/time_tracking/time_tracking_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/timeline/order_timeline_card.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_state.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowOrderDetailsBloc, ShowOrderDetailsState>(
      builder: (context, state) {
        switch (state.status) {
          case ShowOrderDetailsStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case ShowOrderDetailsStatus.failure:
            return Center(
              child: Text(state.failure?.message ?? "Something went wrong"),
            );

          case ShowOrderDetailsStatus.success:
            return _LoadedBody(order: state.response!.data!.orderdetails!);

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          showMenuButton: !Responsive.isDesktop(context),
          title: "تفاصيل الحالة",
          showSearchBar: false,
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "#${order.serialNumber ?? order.id}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Expanded(
          child: OrderDetailsLayout(
            left: Column(
              children: [
                OrderSummaryCard(order: order),

                const SizedBox(height: 24),
                OrderTimelineCard(steps: order.timelineSteps),

                const SizedBox(height: 24),

                NotesCard(notes: order.notes),
              ],
            ),
            right: Column(
              children: [
                PatientInfoCard(order: order),
                SizedBox(height: 20),
                TimeTrackingCard(order: order),
                SizedBox(height: 20),
                AttachmentsCard(order: order),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
