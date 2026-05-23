import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/auth/user_role_cubit.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/login_entity.dart';

import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_state.dart';

import 'package:dental_link_dashboard/features/admin/presentation/cubit/login/login_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

import 'package:dental_link_dashboard/shared/widgets/app_primary_button.dart';
import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, blocState) {
        /// SUCCESS
        if (blocState.isSuccess) {
          context.read<LoginCubit>().clearRateLimitCountdown();

          final token = blocState.response?.data?.token;
          final userData = blocState.response?.data?.user;
          final roles = blocState.response?.data?.roles;

          if (token != null && token.isNotEmpty) {
            locator<AuthTokenStorage>().saveToken(token);
          }

          /// تعيين دور المستخدم
          if (roles != null && roles.isNotEmpty && userData != null) {
            final userRole = roles.first;
            final userName = userData.name ?? 'مستخدم';
            final userId = userData.id ?? 0;

            locator<UserRoleCubit>().setUserRole(
              role: userRole,
              userName: userName,
              userId: userId,
            );
          }

          final message = blocState.response?.message ?? 'Login successful';

          AppSnackbarHelper.showSuccess(
            context,
            title: 'نجاح',
            message: message,
          );

          /// التوجيه بناءً على الدور
          if (roles != null && roles.isNotEmpty) {
            final userRole = roles.first;
            if (userRole == 'lab_manager') {
              LabManagerDashboardRoute().go(context);
            } else if (userRole == 'receptionist') {
              ReceptionistDashboardRoute().go(context);
            } else {
              /// system_admin أو أي دور آخر
              ManageLabsRoute().go(context);
            }
          } else {
            /// في حالة عدم وجود أدوار، انتقل إلى قسم الإدارة الافتراضي
            ManageLabsRoute().go(context);
          }

          return;
        }

        /// FAILURE
        if (blocState.isFailure && blocState.failure != null) {
          final failure = blocState.failure!;

          if (failure.type == AppFailureType.rateLimit) {
            context.read<LoginCubit>().startRateLimitCountdown(
              failure.retryAfterSeconds ?? 0,
            );
          }

          AppSnackbarHelper.showFailure(
            context,
            title: 'خطأ',
            message: failure.message,
            failure: failure,
          );
        }
      },
      builder: (context, blocState) {
        final isLoading = blocState.isLoading;

        return BlocBuilder<LoginCubit, LoginCubitState>(
          builder: (context, cubitState) {
            final buttonText = l10n.loginAction;

            final LoginEntity entity = cubitState.entity;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// EMAIL LABEL
                Text(
                  l10n.email,
                  style: TextStyle(
                    fontSize: AppTypography.fs14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                /// EMAIL FIELD
                AppTextField(
                  hint: 'example@dentallink.com',
                  icon: Icons.email_outlined,
                  textAlign: TextAlign.start,
                  errorText: cubitState.emailError,
                  onChanged: (value) {
                    context.read<LoginCubit>().updateEmail(value);
                  },
                ),

                const SizedBox(height: AppSpacing.lgPlus),

                /// PASSWORD LABEL
                Text(
                  l10n.password,
                  style: TextStyle(
                    fontSize: AppTypography.fs14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                /// PASSWORD FIELD
                AppTextField(
                  hint: '********',
                  icon: Icons.lock_outline,
                  textAlign: TextAlign.start,
                  errorText: cubitState.passwordError,
                  obscureText: !cubitState.isPasswordVisible,
                  onChanged: (value) {
                    context.read<LoginCubit>().updatePassword(value);
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<LoginCubit>().togglePasswordVisibility();
                    },
                    icon: Icon(
                      cubitState.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: AppSizes.alpha6,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                /// LOGIN BUTTON
                AppPrimaryButton(
                  text: cubitState.isRateLimited
                      ? '$buttonText (${cubitState.rateLimitRemainingSeconds}s)'
                      : buttonText,
                  isLoading: isLoading,
                  height: AppSizes.buttonHeight,
                  backgroundColor: theme.colorScheme.primary,
                  borderRadius: AppSizes.buttonRadius,
                  onPressed: (isLoading || cubitState.isRateLimited)
                      ? null
                      : () {
                          final cubit = context.read<LoginCubit>();

                          final isValid = cubit.validateInputs();

                          if (!isValid) {
                            return;
                          }

                          context.read<LoginBloc>().add(
                            LoginSubmitted(
                              entity.copyWith(email: entity.email.trim()),
                            ),
                          );
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
