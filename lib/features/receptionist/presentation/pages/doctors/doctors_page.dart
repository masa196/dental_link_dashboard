import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DoctorsPageMode {
  receptionist,
  labManager,
}

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({
    super.key,
    required this.mode,
  });

   final DoctorsPageMode mode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<ShowDoctorsBloc>()
            ..add(const ShowDoctorsRequested()),
        ),
      ],
      child:  DoctorsView(mode: mode),
    );
  }
}

