import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_event.dart';
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
    return BlocProvider(
      create: (_) =>
          locator<LabManagerProfileBloc>()
            ..add(
              const LabManagerProfileFetchRequested(),
            ),
      child: LabManagerProfileView(
      ),
    );
  }
}