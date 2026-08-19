import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctor_details/doctor_details_view.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsPage extends StatelessWidget {
  final int doctorId;

  const DoctorDetailsPage({
    super.key,
    required this.doctorId,
    required this.mode,
    this.doctorSummary,
  });

  final DoctorsPageMode mode;
  final DoctorModel? doctorSummary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<ShowDoctorDetailsBloc>()
            ..add(ShowDoctorDetailsRequested(doctorId: doctorId)),

      child: DoctorDetailsView(mode: mode, doctorSummary: doctorSummary),
    );
  }
}
