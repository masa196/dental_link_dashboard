import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_doctors/show_doctors_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_statistics.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_empty.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_error.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_loading.dart';
import 'package:dental_link_dashboard/shared/pagination/floating_pagination.dart';

class DoctorsBody extends StatelessWidget {
  const DoctorsBody({
    super.key, required this.mode,
  });

  final DoctorsPageMode mode;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ShowDoctorsBloc, ShowDoctorsState>(

      builder: (context, state) {

        if (state.isLoading && state.doctors.isEmpty) {
          return const DoctorsLoading();
        }

        if (state.failure != null && state.doctors.isEmpty) {
          return DoctorsError(
            failure: state.failure!,
          );
        }
        if (state.doctors.isEmpty) {
          return const DoctorsEmpty();
        }

        return LayoutBuilder(

          builder: (context, constraints) {

            final horizontalPadding = constraints.maxWidth > 1200 ? 32.0: 20.0;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),

              child: Column(
                mainAxisSize:MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  DoctorsStatistics(
                    totals: state.totals,
                  ),

                  const SizedBox(
                    height: 28,
                  ),
                  DoctorsGrid(
                    doctors: state.doctors,
                    mode: mode,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(

                    alignment: Alignment.center,
                    child: ConstrainedBox(

                      constraints:
                          const BoxConstraints(
                            minWidth: 1,
                          ),
                      child: FloatingPagination(

                        currentPage: state.currentPage,
                        totalPages: state.lastPage,

                        onPageChanged: (page) {

                          context.read<ShowDoctorsBloc>().add(

                                ShowDoctorsRequested(
                                  page: page,
                                  search: state.currentSearch,
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}