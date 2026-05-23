import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';

import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/location/location_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/edit_lab_manager/edit_lab_manager_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/edit_lab_manager/edit_lab_manager_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/edit_lab_manager/edit_lab_manager_bloc_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/location/search_location_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/edit_lab_manager/edit_lab_manager_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/location/location_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/map/map_picker_page.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/lab_photo_picker_field.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class EditInfoLabDialog extends StatelessWidget {
  final LabModel lab;

  const EditInfoLabDialog({super.key, required this.lab});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<EditLabManagerCubit>()..initializeFromLab(lab),
        ),
        BlocProvider(create: (_) => locator<EditLabManagerBloc>()),
        BlocProvider(create: (_) => locator<SearchLocationBloc>()),
      ],
      child: _DialogBody(lab: lab),
    );
  }
}

class _DialogBody extends StatelessWidget {
  const _DialogBody({required this.lab});

  final LabModel lab;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 550),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: BlocListener<EditLabManagerBloc, EditLabManagerBlocState>(
          listener: (context, blocState) {
            if (blocState.status == EditLabManagerRemoteStatus.success) {
              Navigator.of(
                context,
              ).pop(blocState.responseModel?.message ?? context.l10n.success);
            }

            if (blocState.status == EditLabManagerRemoteStatus.failure) {
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
                  l10n.editingLaboratoryInformation,
                  style: TextStyle(
                    fontSize: AppTypography.fs18,
                    fontWeight: FontWeight.w700,
                    color: context.scheme.primary,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                Row(
                  children: const [
                    Expanded(
                      child: _LabTextField(
                        title: 'labName',
                        hint: '',
                        icon: Icons.business_outlined,
                        valueSelector: _Selectors.labName,
                        errorSelector: _Selectors.labNameError,
                        onChanged: _CubitActions.updateLabName,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _LabTextField(
                        title: 'labManager',
                        hint: '',
                        icon: Icons.person_outline,
                        valueSelector: _Selectors.managerName,
                        errorSelector: _Selectors.managerNameError,
                        onChanged: _CubitActions.updateManagerName,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                Row(
                  children: const [
                    Expanded(child: _LocationField()),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _LabTextField(
                        title: 'phone',
                        hint: '',
                        icon: Icons.phone_outlined,
                        valueSelector: _Selectors.phone,
                        errorSelector: _Selectors.phoneError,
                        onChanged: _CubitActions.updatePhone,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                const _LabTextField(
                  title: 'email',
                  hint: '',
                  icon: Icons.email_outlined,
                  valueSelector: _Selectors.email,
                  errorSelector: _Selectors.emailError,
                  onChanged: _CubitActions.updateEmail,
                ),

                const SizedBox(height: AppSpacing.md),

                BlocBuilder<EditLabManagerCubit, EditLabManagerCubitState>(
                  builder: (context, state) {
                    return LabPhotoPickerField(
                      title: 'Photo',
                      photoBytes: state.photo,
                      photoUrl: lab.photo,
                      photoName: state.photoName,
                      onPicked: (bytes, fileName) async {
                        context.read<EditLabManagerCubit>().updatePhoto(
                          bytes,
                          fileName,
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                const Row(
                  children: [
                    Expanded(child: _PasswordField(isConfirmation: false)),
                    SizedBox(width: AppSpacing.md),
                    Expanded(child: _PasswordField(isConfirmation: true)),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                          BlocBuilder<
                            EditLabManagerBloc,
                            EditLabManagerBlocState
                          >(
                            builder: (context, blocState) {
                              final isLoading =
                                  blocState.status ==
                                  EditLabManagerRemoteStatus.loading;

                              return FilledButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        final cubit = context
                                            .read<EditLabManagerCubit>();

                                        if (cubit.validateInputs()) {
                                          context
                                              .read<EditLabManagerBloc>()
                                              .add(
                                                EditLabManagerSubmitted(
                                                  params: cubit.state.entity,
                                                ),
                                              );
                                        }
                                      },
                                icon: isLoading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.save, size: 18),
                                label: Text(context.l10n.saveChanges),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.md,
                                  ),
                                ),
                              );
                            },
                          ),
                    ),

                    const SizedBox(width: AppSpacing.md),

                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          context.l10n.cancel,
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
    );
  }
}

class _LabTextField extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;

  final String Function(EditLabManagerCubitState state) valueSelector;

  final String? Function(EditLabManagerCubitState state) errorSelector;

  final void Function(EditLabManagerCubit cubit, String value) onChanged;

  const _LabTextField({
    required this.title,
    required this.hint,
    required this.icon,
    required this.valueSelector,
    required this.errorSelector,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditLabManagerCubit, EditLabManagerCubitState>(
      buildWhen: (previous, current) {
        return valueSelector(previous) != valueSelector(current) ||
            errorSelector(previous) != errorSelector(current);
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title(context),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppTypography.fs16,
              ),
            ),

            const SizedBox(height: AppSpacing.xsPlus),

            TextFormField(
              initialValue: valueSelector(state),
              onChanged: (value) {
                onChanged(context.read<EditLabManagerCubit>(), value);
              },
              decoration: InputDecoration(
                hintText: valueSelector(state).isEmpty
                    ? hint
                    : valueSelector(state),
                hintStyle: TextStyle(
                  fontSize: AppTypography.fs14,
                  color: AppLightColors.hint,
                ),
                prefixIcon: Icon(icon),
                errorText: errorSelector(state),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.smPlus,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _title(BuildContext context) {
    switch (title) {
      case 'labName':
        return context.l10n.labName;

      case 'labManager':
        return context.l10n.labManager;

      case 'phone':
        return context.l10n.phoneNumber;

      case 'email':
        return context.l10n.email;

      default:
        return '';
    }
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchLocationBloc, SearchLocationState>(
      builder: (context, searchState) {
        return BlocBuilder<EditLabManagerCubit, EditLabManagerCubitState>(
          builder: (context, state) {
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

                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.trim().isEmpty) {
                      return const Iterable<LocationModel>.empty();
                    }

                    if (searchState is SearchLocationLoaded) {
                      return searchState.model;
                    }

                    return const Iterable<LocationModel>.empty();
                  },

                  onSelected: (LocationModel selection) {
                    context.read<EditLabManagerCubit>().updateLocation(
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
                        if (controller.text.isEmpty &&
                            state.entity.location?.name?.trim().isNotEmpty ==
                                true) {
                          controller.text = state.entity.location!.name!;
                        }

                        return TextField(
                          controller: controller,
                          focusNode: focusNode,

                          onChanged: (value) {
                            if (value.trim().isEmpty) {
                              return;
                            }

                            context.read<SearchLocationBloc>().add(
                              SearchLocationEvent(
                                CreateLabManagerEntity(
                                  labName: state.entity.labName,
                                  managerName: state.entity.managerName,
                                  email: state.entity.email,
                                  phone: state.entity.phone,
                                  password: state.entity.password,
                                  passwordConfirmation:
                                      state.entity.passwordConfirmation,
                                  location: LocationEntity(name: value),
                                ),
                              ),
                            );
                          },

                          decoration: InputDecoration(
                            hintText:
                                state.entity.location?.name?.isNotEmpty == true
                                ? state.entity.location!.name
                                : context.l10n.exampleAddress,

                            hintStyle: TextStyle(
                              fontSize: AppTypography.fs14,
                              color: AppLightColors.hint,
                            ),

                            errorText: state.locationError,

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

                                if (result is LocationModel &&
                                    context.mounted) {
                                  controller.text = result.name;

                                  context
                                      .read<EditLabManagerCubit>()
                                      .updateLocation(
                                        LocationEntity(
                                          name: result.name,
                                          lat: result.lat,
                                          lng: result.lng,
                                          isSelected: true,
                                        ),
                                      );
                                }
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
                                onTap: () {
                                  onSelected(option);
                                },
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

class _PasswordField extends StatelessWidget {
  final bool isConfirmation;

  const _PasswordField({required this.isConfirmation});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditLabManagerCubit, EditLabManagerCubitState>(
      builder: (context, state) {
        final cubit = context.read<EditLabManagerCubit>();

        final isHidden = isConfirmation
            ? state.hideConfirmPassword
            : state.hidePassword;

        final error = isConfirmation
            ? state.passwordConfirmationError
            : state.passwordError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isConfirmation
                  ? context.l10n.confirmPassword
                  : context.l10n.password,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppTypography.fs16,
              ),
            ),

            const SizedBox(height: AppSpacing.xsPlus),

            TextFormField(
              initialValue: '',
              obscureText: isHidden,

              onChanged: isConfirmation
                  ? cubit.updatePasswordConfirmation
                  : cubit.updatePassword,

              decoration: InputDecoration(
                hintText: '••••••••',

                hintStyle: TextStyle(
                  fontSize: AppTypography.fs14,
                  color: AppLightColors.hint,
                ),

                errorText: error,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.smPlus,
                ),

                suffixIcon: IconButton(
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ),
                  onPressed: isConfirmation
                      ? cubit.toggleConfirmPasswordVisibility
                      : cubit.togglePasswordVisibility,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Selectors {
  static String labName(EditLabManagerCubitState state) => state.entity.labName;

  static String managerName(EditLabManagerCubitState state) =>
      state.entity.managerName;

  static String email(EditLabManagerCubitState state) => state.entity.email;

  static String phone(EditLabManagerCubitState state) => state.entity.phone;

  static String? labNameError(EditLabManagerCubitState state) =>
      state.labNameError;

  static String? managerNameError(EditLabManagerCubitState state) =>
      state.managerNameError;

  static String? emailError(EditLabManagerCubitState state) => state.emailError;

  static String? phoneError(EditLabManagerCubitState state) => state.phoneError;
}

class _CubitActions {
  static void updateLabName(EditLabManagerCubit cubit, String value) {
    cubit.updateLabName(value);
  }

  static void updateManagerName(EditLabManagerCubit cubit, String value) {
    cubit.updateManagerName(value);
  }

  static void updateEmail(EditLabManagerCubit cubit, String value) {
    cubit.updateEmail(value);
  }

  static void updatePhone(EditLabManagerCubit cubit, String value) {
    cubit.updatePhone(value);
  }
}

