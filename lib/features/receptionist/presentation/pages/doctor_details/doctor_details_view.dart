import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctor_details/show_doctor_details_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctor_details/widgets/doctor_orders_section.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctor_details/widgets/doctor_profile_card.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key, required this.mode, this.doctorSummary});

  final DoctorsPageMode mode;
  final DoctorModel? doctorSummary;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowDoctorDetailsBloc, ShowDoctorDetailsState>(
      builder: (context, state) {
        if (state.isLoadingDoctor) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.failure != null) {
          return Center(child: Text(state.failure!.message));
        }

        final doctor = state.doctorInfo;

        if (doctor == null) {
          return const Center(child: Text('لا توجد بيانات للطبيب'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              DoctorProfileCard(doctor: doctor, doctorSummary: doctorSummary),

              const SizedBox(height: 24),

              DoctorOrdersSection(
                mode: mode,
                doctorId: doctor.doctorId ?? 1,
                orders: state.orders,

                pagination: state.pagination,

                paymentStatus: state.currentPaymentStatus,

                onPaymentStatusChanged: (status) {
                  context.read<ShowDoctorDetailsBloc>().add(
                    ShowDoctorPaymentFilterChanged(paymentStatus: status),
                  );
                },

                onPageChanged: (page) {
                  context.read<ShowDoctorDetailsBloc>().add(
                    ShowDoctorOrdersPageChanged(page: page),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
