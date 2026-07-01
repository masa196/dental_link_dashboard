import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';
import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';
import 'edit_employee_section_card.dart';

class EditEmployeeContactSection extends StatelessWidget {
  const EditEmployeeContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return EditEmployeeSectionCard(
      title: isArabic ? 'معلومات التواصل' : 'Contact information',
      icon: Icons.phone_outlined,
      children: [
        BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 680;

                final emailField = AppTextField(
                  initialValue: state.email,
                  labelText: isArabic ? 'البريد الإلكتروني' : 'Email address',
                  hint: isArabic ? 'أدخل البريد الإلكتروني' : 'Enter email address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  errorText: state.emailError,
                  onTap: () => context.read<UpdateEmployeeFormCubit>().clearEmailError(),
                  onChanged: context.read<UpdateEmployeeFormCubit>().updateEmail,
                );

                final phoneField = AppTextField(
                  initialValue: state.phone,
                  labelText: isArabic ? 'رقم الهاتف' : 'Phone number',
                  hint: isArabic ? 'أدخل رقم الهاتف' : 'Enter phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  errorText: state.phoneError,
                  onTap: () => context.read<UpdateEmployeeFormCubit>().clearPhoneError(),
                  onChanged: context.read<UpdateEmployeeFormCubit>().updatePhone,
                );

                if (isCompact) {
                  return Column(
                    children: [
                      emailField,
                      const SizedBox(height: AppSpacing.md),
                      phoneField,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: emailField),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: phoneField),
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