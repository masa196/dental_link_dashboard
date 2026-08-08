import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/lab_manager_profile/lab_manager_profile_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/stripe_link/stripe_link_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/stripe_link/stripe_link_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/header/profile_header.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/profile_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/profile_info_card.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LabManagerProfileView extends StatefulWidget {
  const LabManagerProfileView({super.key});

  @override
  State<LabManagerProfileView> createState() => _LabManagerProfileViewState();
}

class _LabManagerProfileViewState extends State<LabManagerProfileView> {
  late final ScrollController _verticalController;
  late final ScrollController _horizontalController;
  

  @override
  void initState() {
    super.initState();

    _verticalController = ScrollController();
    _horizontalController = ScrollController();
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();

    super.dispose();
  }

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
  child: LayoutBuilder(
    builder: (context, pageConstraints) {
      const minHeight = 350.0;

      final isShortHeight =
          pageConstraints.maxHeight < minHeight;

      if (isShortHeight) {
        return Scrollbar(
          controller: _verticalController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _verticalController,
            primary: false,
            child: Column(
              children: [
                DashboardHeader(
                  title: context.isArabic
                      ? 'الملف الشخصي'
                      : 'Profile',
                  showSearchBar: false,
                  showMenuButton:
                      !Responsive.isDesktop(context),
                ),

                const SizedBox(height: 24),

                LayoutBuilder(
                  builder: (context, constraints) {
                    return Scrollbar(
                      controller: _horizontalController,
                      thumbVisibility: true,
                      notificationPredicate:
                          (notification) =>
                              notification.metrics.axis ==
                              Axis.horizontal,
                      child: SingleChildScrollView(
                        controller: _horizontalController,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: constraints.maxWidth < 900
                              ? 900
                              : constraints.maxWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: _buildProfileContent(
                              user: user,
                              state: state,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: [
          DashboardHeader(
            title: context.isArabic
                ? 'الملف الشخصي'
                : 'Profile',
            showSearchBar: false,
            showMenuButton:
                !Responsive.isDesktop(context),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Scrollbar(
                  controller: _verticalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _verticalController,
                    primary: false,
                    child: Scrollbar(
                      controller: _horizontalController,
                      thumbVisibility: true,
                      notificationPredicate:
                          (notification) =>
                              notification.metrics.axis ==
                              Axis.horizontal,
                      child: SingleChildScrollView(
                        controller: _horizontalController,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: constraints.maxWidth < 900
                              ? 900
                              : constraints.maxWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: _buildProfileContent(
                              user: user,
                              state: state,
                            ),
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
      );
    },
  ),
);
      },
    );
  }

  Widget _buildProfileContent({
  required UserInProfile user,
  required LabManagerProfileState state,
}) {
  return Column(
    children: [
      ProfileHeader(
        user: user,
        roles: state.response?.data?.roles ?? [],
      ),

      const SizedBox(height: 28),

      const _StripeStatusCard(),

      const SizedBox(height: 44),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
  );
}
}

class _StripeStatusCard extends StatelessWidget {
  const _StripeStatusCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StripeLinkBloc, StripeLinkState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox.shrink();
        }

        final failure = state.failure;

        // 400 = Stripe account is already active.
        if (failure?.statusCode == 400) {
          return const _StripeInfoContent(
            icon: Icons.check_circle_outline,
            message: 'لديك حساب Stripe مفعل وجاهز للاستخدام',
          );
        }

        // Any failure other than 400 = show nothing.
        if (failure != null) {
          return const SizedBox.shrink();
        }

        // Successful response.
        final url = state.response?.data?.url;

        if (url == null || url.isEmpty) {
          return const SizedBox.shrink();
        }

        return _StripeInfoContent(
          icon: Icons.account_balance_outlined,
          message:
              'لديك حساب Stripe لكنه يحتاج إلى تكملة معلومات حتى يتم تفعيله بشكل صحيح',
          url: url,
        );
      },
    );
  }
}

class _StripeInfoContent extends StatelessWidget {
  const _StripeInfoContent({
    required this.icon,
    required this.message,
    this.url,
  });

  final IconData icon;
  final String message;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      title: 'حساب Stripe',
      icon: icon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            
            style: TextStyle(
              fontSize: AppTypography.fs14,
              fontWeight: FontWeight.w600,
              color: context.scheme.onSurface,
              height: 1.6,
            ),
          ),

          if (url != null) ...[
            const SizedBox(height: AppSpacing.md),

            InkWell(
              onTap: () => _openStripeLink(context, url!),
              borderRadius: BorderRadius.circular(
                AppRadius.md,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: context.scheme.primary.withValues(
                    alpha: 0.07,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(
                      Icons.open_in_new_outlined,
                      size: 18,
                      color: context.scheme.primary,
                    ),

                    const SizedBox(
                      width: AppSpacing.sm,
                    ),

                    Expanded(
                      child: Text(
                        url!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: AppTypography.fs13,
                          fontWeight: FontWeight.w600,
                          color: context.scheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

 Future<void> _openStripeLink(
  BuildContext context,
  String url,
) async {
  final uri = Uri.tryParse(url);

  if (uri == null) {
    return;
  }

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}
}
