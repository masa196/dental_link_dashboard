import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctor_card.dart';
import 'package:flutter/material.dart';


class DoctorsGrid extends StatelessWidget {
  const DoctorsGrid({super.key, required this.doctors, required this.mode});

  final List<DoctorModel> doctors;
  final DoctorsPageMode mode;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 20.0;
        const minimumCardWidth = 260.0;

        int columns = (constraints.maxWidth / (minimumCardWidth + spacing))
            .floor();

        if (columns < 1) {
          columns = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,

            crossAxisSpacing: spacing,

            mainAxisSpacing: spacing,

            // هنا التعديل المهم
            mainAxisExtent: 300,
          ),

          itemCount: doctors.length,

          itemBuilder: (context, index) {
            final doctor = doctors[index];

            return DoctorCard(
              doctor: doctor,

              onDetailsTap: () {
                if (doctor.doctorId == null) {
                  return;
                }

               

                if (mode == DoctorsPageMode.labManager) {
                  LabManagerDoctorDetailsRoute(
                    doctorId: doctor.doctorId!,
                  ).go(context);
                } else {
                  ReceptionistDoctorDetailsRoute(
                    doctorId: doctor.doctorId!,
                  ).go(context);
                }
              },
            );
          },
        );
      },
    );
  }
}
