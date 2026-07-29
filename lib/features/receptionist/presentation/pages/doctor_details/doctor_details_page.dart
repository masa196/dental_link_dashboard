
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsPage extends StatelessWidget {

  final int doctorId;

  const DoctorDetailsPage({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => locator<ShowDoctorDetailsBloc>()
        ..add(
          ShowDoctorDetailsRequested(
            doctorId: doctorId,
          ),
        ),

      child: Center
      (
        child: Text('Doctor Details Page'),
      ),
    );

  }
}