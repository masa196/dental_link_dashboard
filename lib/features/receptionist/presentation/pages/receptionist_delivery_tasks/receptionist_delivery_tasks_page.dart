import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/receptionist_delivery_tasks_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionistDeliveryTasksPage extends StatelessWidget {
  const ReceptionistDeliveryTasksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<ShowDeliveryTasksBloc>()
            ..add(const ShowDeliveryTasksRequested()),
        ),
      ],
      child: const ReceptionistDeliveryTasksView(),
    );
  }
}