import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_state.dart';
import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';

import 'create_employee_section_card.dart';

class CreateEmployeeSecuritySection extends StatelessWidget {
  const CreateEmployeeSecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return CreateEmployeeSectionCard(
      title: isArabic ? 'الأمان' : 'Security',
      icon: Icons.lock_outline,
      children: [
        BlocBuilder<CreateEmployeeFormCubit, CreateEmployeeFormState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 680;
                final passwordField = AppTextField(
                  initialValue: state.password,
                  labelText: isArabic ? 'كلمة المرور' : 'Password',
                  hint: isArabic ? 'أدخل كلمة المرور' : 'Enter password',
                  icon: Icons.lock_outline,
                  obscureText: !state.isPasswordVisible,
                  errorText: state.passwordError,
                  onTap: () => context
                      .read<CreateEmployeeFormCubit>()
                      .clearPasswordError(),
                  onChanged: context
                      .read<CreateEmployeeFormCubit>()
                      .updatePassword,
                  suffixIcon: IconButton(
                    onPressed: () => context
                        .read<CreateEmployeeFormCubit>()
                        .togglePasswordVisibility(),
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                );

                final confirmationField = AppTextField(
                  initialValue: state.confirmPassword,
                  labelText: isArabic
                      ? 'تأكيد كلمة المرور'
                      : 'Confirm password',
                  hint: isArabic
                      ? 'أعد إدخال كلمة المرور'
                      : 'Re-enter password',
                  icon: Icons.lock_reset_outlined,
                  obscureText: !state.isConfirmPasswordVisible,
                  errorText: state.confirmPasswordError,
                  onTap: () => context
                      .read<CreateEmployeeFormCubit>()
                      .clearConfirmPasswordError(),
                  onChanged: context
                      .read<CreateEmployeeFormCubit>()
                      .updateConfirmPassword,
                  suffixIcon: IconButton(
                    onPressed: () => context
                        .read<CreateEmployeeFormCubit>()
                        .toggleConfirmPasswordVisibility(),
                    icon: Icon(
                      state.isConfirmPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                );

                if (isCompact) {
                  return Column(
                    children: [
                      passwordField,
                      const SizedBox(height: AppSpacing.md),
                      confirmationField,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: passwordField),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: confirmationField),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
