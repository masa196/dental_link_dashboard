import 'package:dental_link_dashboard/notifications/services/firebase/firebase_messaging_service.dart';
import 'package:dental_link_dashboard/notifications/domain/entities/device_token_entity.dart';
import 'package:dental_link_dashboard/notifications/domain/usecases/create_device_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

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

 Future<void> _registerDeviceToken() async {

  try {

    final messagingService =
        locator<FirebaseMessagingService>();

    final fcmToken =
        await messagingService.getToken();


    if (fcmToken == null ||
        fcmToken.isEmpty) {

      debugPrint(
        "FCM token unavailable",
      );

      return;
    }


    await locator<CreateDeviceTokenUseCase>()
        .call(
          DeviceTokenEntity(
            token: fcmToken,
            deviceType: 'web',
          ),
        );


  } catch(e){

    debugPrint(
      "Device token registration skipped: $e",
    );

  }
}

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, blocState) async {
        /// SUCCESS
        if (blocState.isSuccess) {
          context.read<LoginCubit>().clearRateLimitCountdown();

          final token = blocState.response?.data?.token;
          final userData = blocState.response?.data?.user;
          final roles = blocState.response?.data?.roles;

          if (roles == null || roles.isEmpty) {
            AppSnackbarHelper.showFailure(
              context,
              title: 'خطأ',
              message: 'لم يتم العثور على دور للمستخدم.',
            );
            return;
          }

          final userRole = roles.first;

          /// السماح فقط بالأدوار المدعومة
          if (userRole != 'system_admin' &&
              userRole != 'lab_manager' &&
              userRole != 'receptionist') {
            AppSnackbarHelper.showFailure(
              context,
              title: 'خطأ',
              message: 'هذا الدور غير مدعوم في لوحة التحكم.',
            );
            return;
          }

          if (token != null && token.isNotEmpty) {
            await locator<AuthTokenStorage>().saveToken(token);

            try {
              locator<FirebaseMessagingService>().startListening();

              unawaited(_registerDeviceToken());
            } catch (e) {
              debugPrint("Firebase login setup failed: $e");
            }
          }

          if (userData != null) {
            locator<UserRoleCubit>().setUserRole(
              role: userRole,
              userName: userData.name ?? 'مستخدم',
              userId: userData.id ?? 0,
            );
          }

          AppSnackbarHelper.showSuccess(
            context,
            title: 'نجاح',
            message: blocState.response?.message ?? 'Login successful',
          );

          switch (userRole) {
            case 'lab_manager':
              LabManagerDashboardRoute().go(context);
              break;

            case 'receptionist':
              ReceptionistDashboardRoute().go(context);
              break;

            case 'system_admin':
              ManageLabsRoute().go(context);
              break;
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
