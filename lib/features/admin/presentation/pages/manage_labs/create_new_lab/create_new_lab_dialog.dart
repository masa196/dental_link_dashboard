import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/location/location_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/create_lab_manager/create_lab_manager_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/create_lab_manager/create_lab_manager_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/create_lab_manager/create_lab_manager_bloc_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/location/search_location_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/create_lab_manager/create_lab_manager_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/create_lab_manager/create_lab_manager_cubit_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/location/location_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/map/map_picker_page.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/lab_photo_picker_field.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewLabDialog extends StatelessWidget {
  const CreateNewLabDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<CreateLabManagerCubit>()),
        BlocProvider(create: (_) => locator<CreateLabManagerBloc>()),
        BlocProvider(create: (_) => locator<SearchLocationBloc>()),
      ],
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 550),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: BlocListener<CreateLabManagerBloc, CreateLabManagerBlocState>(
            listener: (context, blocState) {
              if (blocState.status == CreateLabManagerRemoteStatus.success) {
                final successMessage =
                    blocState.responseModel?.message ?? context.l10n.success;
                Navigator.of(context).pop(successMessage);
                return;
              }

              if (blocState.status == CreateLabManagerRemoteStatus.failure) {
                AppSnackbarHelper.showFailure(
                  context,
                  title: context.l10n.error,
                  message: blocState.failure?.message ?? context.l10n.error,
                  failure: blocState.failure,
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.addNewLab,
                    style: TextStyle(
                      fontSize: AppTypography.fs18,
                      fontWeight: FontWeight.w700,
                      color: context.scheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _BuildResponsiveGrid(),
                  const SizedBox(height: AppSpacing.md),
                  BlocBuilder<
                    CreateLabManagerCubit,
                    CreateLabManagerCubitState
                  >(
                    buildWhen: (p, c) =>
                        p.entity.photo != c.entity.photo ||
                        p.entity.photoName != c.entity.photoName,
                    builder: (context, state) {
                      return LabPhotoPickerField(
                        title: l10n.labLogo,
                        photoBytes: state.entity.photo,
                        photoName: state.entity.photoName,
                        onPicked: (bytes, fileName) async {
                          context.read<CreateLabManagerCubit>().onPhotoChanged(
                            bytes,
                            fileName,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: SizedBox(width: 400, child: _EmailField()),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(child: _PasswordField()),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: _ConfirmPasswordField()),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Expanded(flex: 2, child: _SubmitButton()),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            l10n.cancel,
                            style: TextStyle(color: context.scheme.onSurface),
                          ),
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
  }
}

class _BuildResponsiveGrid extends StatelessWidget {
  const _BuildResponsiveGrid();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _LabNameField()),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: _ManagerNameField()),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _LocationSearchField()),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: _PhoneField()),
          ],
        ),
      ],
    );
  }
}

class _LabNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      buildWhen: (p, c) =>
          p.entity.labName != c.entity.labName ||
          p.labNameError != c.labNameError,
      builder: (context, state) {
        return _BuildTextField(
          label: context.l10n.labName,
          hint: context.l10n.exampleLabName,
          error: state.labNameError,
          onChanged: (v) =>
              context.read<CreateLabManagerCubit>().onLabNameChanged(v),
        );
      },
    );
  }
}

class _ManagerNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      buildWhen: (p, c) =>
          p.entity.managerName != c.entity.managerName ||
          p.managerNameError != c.managerNameError,
      builder: (context, state) {
        return _BuildTextField(
          label: context.l10n.labManager,
          hint: context.l10n.exampleManagerName,
          error: state.managerNameError,
          onChanged: (v) =>
              context.read<CreateLabManagerCubit>().onManagerNameChanged(v),
        );
      },
    );
  }
}

class _PhoneField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      buildWhen: (p, c) =>
          p.entity.phone != c.entity.phone || p.phoneError != c.phoneError,
      builder: (context, state) {
        return _BuildTextField(
          label: context.l10n.phoneNumber,
          hint: '09xxxxxxxx',
          error: state.phoneError,
          onChanged: (v) =>
              context.read<CreateLabManagerCubit>().onPhoneChanged(v),
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      buildWhen: (p, c) =>
          p.entity.email != c.entity.email || p.emailError != c.emailError,
      builder: (context, state) {
        return _BuildTextField(
          label: context.l10n.email,
          hint: 'example@lab.com',
          error: state.emailError,
          onChanged: (v) =>
              context.read<CreateLabManagerCubit>().onEmailChanged(v),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      buildWhen: (p, c) =>
          p.entity.password != c.entity.password ||
          p.entity.hidePassword != c.entity.hidePassword ||
          p.passwordError != c.passwordError,
      builder: (context, state) {
        return _BuildTextField(
          label: context.l10n.password,
          hint: '********',
          error: state.passwordError,
          isPassword: state.entity.hidePassword ?? true,
          onChanged: (v) =>
              context.read<CreateLabManagerCubit>().onPasswordChanged(v),
          onPasswordToggle: () =>
              context.read<CreateLabManagerCubit>().togglePasswordVisibility(),
        );
      },
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      buildWhen: (p, c) =>
          p.entity.passwordConfirmation != c.entity.passwordConfirmation ||
          p.entity.hideConfirm != c.entity.hideConfirm ||
          p.passwordConfirmationError != c.passwordConfirmationError,
      builder: (context, state) {
        return _BuildTextField(
          label: context.l10n.confirmPassword,
          hint: '********',
          error: state.passwordConfirmationError,
          isPassword: state.entity.hideConfirm ?? true,
          onChanged: (v) =>
              context.read<CreateLabManagerCubit>().onConfirmPasswordChanged(v),
          onPasswordToggle: () =>
              context.read<CreateLabManagerCubit>().toggleConfirmVisibility(),
        );
      },
    );
  }
}

class _LocationSearchField extends StatelessWidget {
  const _LocationSearchField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerCubit, CreateLabManagerCubitState>(
      // إعادة البناء فقط عند تغيير العنوان أو ظهور/اختفاء الخطأ
      buildWhen: (p, c) =>
          p.entity.location != c.entity.location ||
          p.locationError != c.locationError,
      builder: (context, cubitState) {
        return BlocBuilder<SearchLocationBloc, SearchLocationState>(
          builder: (context, searchState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.address,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppTypography.fs16,
                  ),
                ),
                const SizedBox(height: AppSpacing.xsPlus),
                Autocomplete<LocationModel>(
                  displayStringForOption: (option) => option.name,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.trim().isEmpty) {
                      return const Iterable<LocationModel>.empty();
                    }
                    if (searchState is SearchLocationLoaded) {
                      return searchState.model;
                    }
                    return const Iterable<LocationModel>.empty();
                  },
                  onSelected: (selection) {
                    context.read<CreateLabManagerCubit>().onLocationChanged(
                      LocationEntity(
                        name: selection.name,
                        lat: selection.lat,
                        lng: selection.lng,
                        isSelected: true,
                      ),
                    );
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onChanged: (value) {
                            context
                                .read<CreateLabManagerCubit>()
                                .onLocationChanged(
                                  LocationEntity(
                                    name: value,
                                    isSelected: false,
                                  ),
                                );
                            if (value.trim().isEmpty) return;
                            context.read<SearchLocationBloc>().add(
                              SearchLocationEvent(
                                CreateLabManagerEntity(
                                  location: LocationEntity(name: value),
                                ),
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: context.l10n.exampleAddress,
                            errorText: cubitState.locationError,
                            hintStyle: TextStyle(
                              fontSize: AppTypography.fs14,
                              color: AppLightColors.hint,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.smPlus,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.location_on_outlined),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => LocationCubit(),
                                      child: const MapPickerPage(),
                                    ),
                                  ),
                                );

                                if (!context.mounted ||
                                    result == null ||
                                    result is! LocationModel) {
                                  return;
                                }

                                controller.text = result.name;
                                context
                                    .read<CreateLabManagerCubit>()
                                    .onLocationChanged(
                                      LocationEntity(
                                        name: result.name,
                                        lat: result.lat,
                                        lng: result.lng,
                                        isSelected: true,
                                      ),
                                    );
                              },
                            ),
                          ),
                        );
                      },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 350,
                          constraints: const BoxConstraints(maxHeight: 250),
                          color: Colors.white,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              return ListTile(
                                leading: const Icon(Icons.location_on_outlined),
                                title: Text(
                                  option.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLabManagerBloc, CreateLabManagerBlocState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, blocState) {
        final isLoading =
            blocState.status == CreateLabManagerRemoteStatus.loading;

        return FilledButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  final cubit = context.read<CreateLabManagerCubit>();
                  final isValid = cubit.validate(context.l10n);
                  if (isValid) {
                    context.read<CreateLabManagerBloc>().add(
                      CreateLabManagerSubmitted(params: cubit.state.entity),
                    );
                  }
                },
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add_circle_outline, size: 18),
          label: Text(
            isLoading ? context.l10n.loading : context.l10n.addLabAction,
          ),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          ),
        );
      },
    );
  }
}

class _BuildTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? error;
  final bool isPassword;
  final Function(String) onChanged;
  final VoidCallback? onPasswordToggle;

  const _BuildTextField({
    required this.label,
    required this.hint,
    this.error,
    this.isPassword = false,
    required this.onChanged,
    this.onPasswordToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppTypography.fs16,
          ),
        ),
        const SizedBox(height: AppSpacing.xsPlus),
        TextField(
          obscureText: isPassword,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            hintStyle: TextStyle(
              fontSize: AppTypography.fs14,
              color: AppLightColors.hint,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.smPlus,
            ),
            suffixIcon: onPasswordToggle != null
                ? IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: onPasswordToggle,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
