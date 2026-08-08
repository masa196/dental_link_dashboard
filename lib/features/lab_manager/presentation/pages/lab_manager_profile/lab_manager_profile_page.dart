import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/stripe_link/stripe_link_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/stripe_link/stripe_link_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/lab_manager_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabManagerProfilePage extends StatelessWidget {
  const LabManagerProfilePage({
    super.key,
    this.onMenuTap,
    this.showMenu = false,
  });

  final VoidCallback? onMenuTap;
  final bool showMenu;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<LabManagerProfileBloc>()
            ..add(
              const LabManagerProfileFetchRequested(),
            ),
        ),
        BlocProvider(
          create: (_) => locator<StripeLinkBloc>()
            ..add(
              const StripeLinkRequested(),
            ),
        ),
      ],
      child: const LabManagerProfileView(),
    );
  }
}