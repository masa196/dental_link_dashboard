import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/update_package_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/update_package/update_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/update_package/update_package_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/update_package/update_package_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePackageDialog extends StatefulWidget {
  const UpdatePackageDialog({super.key, required this.package});
  final PackageItemModel package;
  @override
  State<UpdatePackageDialog> createState() => _UpdatePackageDialogState();
}

class _UpdatePackageDialogState extends State<UpdatePackageDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late int selectedMonths;
  late bool isActive;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.package.name ?? "");

    descriptionController = TextEditingController(
      text: widget.package.description ?? "",
    );

    priceController = TextEditingController(text: widget.package.price ?? "");

    final days = widget.package.durationDays ?? 30;

    if (days >= 360) {
      selectedMonths = 12;
    } else {
      selectedMonths = (days / 30).round().clamp(1, 12);
    }

    isActive = widget.package.isActive ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();

    descriptionController.dispose();

    priceController.dispose();

    super.dispose();
  }

  int _calculateDurationDays() {
    return selectedMonths * 30;
  }

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
    });
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final entity = UpdatePackageEntity(
      id: widget.package.id!,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      durationDays: _calculateDurationDays(),
      price: double.parse(priceController.text.trim()),

      isActive: isActive,
    );
    context.read<UpdatePackageBloc>().add(
      UpdatePackageRequested(parameters: entity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<UpdatePackageBloc, UpdatePackageState>(
      listener: (context, state) {
        if (state.success) {
          context.read<ShowPackagesBloc>().add(const ShowPackagesRefresh());

          AppSnackbarHelper.showSuccess(
            context,
            title: "تم التعديل",
            message: state.message ?? "تم تعديل الباقة بنجاح",
          );
          Navigator.pop(context);
        }

        if (state.failure != null) {
          AppSnackbarHelper.showFailure(
            context,
            title: "فشل التعديل",
            message: state.failure!.message,
            failure: state.failure,
          );
        }
      },
      child: AlertDialog(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        title: const Text("تعديل الباقة"),
        content: SizedBox(
          width: 430,
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _Field(controller: nameController, label: "اسم الباقة"),

                  const SizedBox(height: 16),

                  _MonthsField(
                    value: selectedMonths,

                    onChanged: (value) {
                      setState(() {
                        selectedMonths = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  _Field(
                    controller: priceController,

                    label: "السعر",

                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يرجى إدخال السعر";
                      }

                      if (double.tryParse(value.trim()) == null) {
                        return "السعر يجب أن يكون رقماً";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  _Field(
                    controller: descriptionController,

                    label: "الوصف (اختياري)",
                    maxLines: 3,
                    required: false,
                  ),
                  const SizedBox(height: 22),
                  Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      "حالة الباقة",

                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,

                    child: SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(
                          value: true,

                          label: Text("متاحة"),

                          icon: Icon(Icons.check_circle_outline),
                        ),

                        ButtonSegment(
                          value: false,

                          label: Text("غير متاحة"),

                          icon: Icon(Icons.block),
                        ),
                      ],

                      selected: {isActive},
                      onSelectionChanged: (value) {
                        setState(() {
                          isActive = value.first;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },

            child: const Text("إلغاء"),
          ),

          BlocBuilder<UpdatePackageBloc, UpdatePackageState>(
            builder: (context, state) {
              return FilledButton(
                onPressed: state.isLoading ? null : _submit,

                child: state.isLoading
                    ? const SizedBox(
                        width: 18,

                        height: 18,

                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("حفظ"),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MonthsField extends StatelessWidget {
  const _MonthsField({required this.value, required this.onChanged});

  final int value;

  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,

      decoration: InputDecoration(
        labelText: "مدة الاشتراك",

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),

      items: List.generate(12, (index) {
        final month = index + 1;

        return DropdownMenuItem<int>(
          value: month,

          child: Text(_formatMonth(month)),
        );
      }),

      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }

  String _formatMonth(int month) {
    if (month == 1) {
      return "شهر واحد";
    }

    if (month == 2) {
      return "شهران";
    }

    if (month == 12) {
      return "سنة";
    }

    return "$month أشهر";
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,

    required this.label,

    this.maxLines = 1,

    this.keyboardType,

    this.validator,

    this.required = true,
  });

  final TextEditingController controller;

  final String label;

  final int maxLines;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;

  final bool required;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      maxLines: maxLines,

      keyboardType: keyboardType,

      textDirection: TextDirection.rtl,

      validator:
          validator ??
          (value) {
            if (!required) {
              return null;
            }

            if (value == null || value.trim().isEmpty) {
              return "يرجى إدخال $label";
            }

            return null;
          },

      decoration: InputDecoration(
        labelText: label,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
