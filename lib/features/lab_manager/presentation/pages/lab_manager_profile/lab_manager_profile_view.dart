import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/header/profile_header.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/profile_info_card.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabManagerProfileView extends StatelessWidget {
  const LabManagerProfileView({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabManagerProfileBloc, LabManagerProfileState>(
      builder: (context, state) {
        if (state.isInitialLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.isFailure) {
          return Center(
            child: Text(state.failure?.message ?? 'Something went wrong'),
          );
        }
        final user = state.user;

        if (user == null) {
          return const Center(child: Text('No profile data'));
        }
        return Directionality(
          textDirection: context.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,

          child: Column(
            children: [
              DashboardHeader(
                title: context.isArabic ? 'الملف الشخصي' : 'Profile',
                showSearchBar: false,
                showMenuButton: !Responsive.isDesktop(context),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Scrollbar(
                      thumbVisibility: true,

                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: constraints.maxWidth < 900
                                ? 900
                                : constraints.maxWidth,

                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  ProfileHeader(
                                    user: user,
                                    roles: state.response?.data?.roles ?? [],
                                  ),

                                  const SizedBox(height: 44),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ProfileInfoCard.contact(
                                          user: user,
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        child: ProfileInfoCard.personal(
                                          user: user,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
