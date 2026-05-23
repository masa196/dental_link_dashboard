import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/login/login_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/widgets/login_background.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/widgets/login_card.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/widgets/login_form.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/widgets/login_header.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/login/widgets/login_info_note.dart';
import 'package:dental_link_dashboard/l10n/locale_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    final double cardWidth = AppSizes.cardWidth(size);
    final bool isArabic = context.isArabic;

    return BlocProvider(
      create: (_) => locator<LoginCubit>(),
      child: BlocProvider(
        create: (_) => locator<LoginBloc>(),
        child: Scaffold(
          body: Stack(
            children: [
              LoginBackground(overlayOpacity: 0.25),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.mdMinus),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          ManageLabsRoute().go(context);
                        },
                        icon: const Icon(
                          Icons.open_in_new,
                          size: AppSpacing.md,
                        ),
                        label: Text(l10n.manageLabsShortcut),
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.smPlus,
                            vertical: AppSpacing.xsPlus,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          context.read<LocaleCubit>().toggle();
                        },
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.smPlus,
                            vertical: AppSpacing.xsPlus,
                          ),
                        ),
                        child: Text(isArabic ? 'EN' : 'AR'),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AppSizes.screenPadding(size),
                    child: LoginCard(
                      width: cardWidth,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoginHeader(),
                          SizedBox(height: AppSpacing.xl),
                          LoginForm(),
                          SizedBox(height: AppSpacing.lg),
                          Divider(),
                          SizedBox(height: AppSpacing.mdMinus),
                          LoginInfoNote(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
