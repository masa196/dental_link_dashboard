import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/update_material_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/update_materials/update_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/update_materials/update_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/update_materials/update_materials_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMaterialDialog extends StatefulWidget {
  const UpdateMaterialDialog({
    super.key,
    required this.material,
  });

  final MaterialItem material;

  @override
  State<UpdateMaterialDialog> createState() =>
      _UpdateMaterialDialogState();
}

class _UpdateMaterialDialogState
    extends State<UpdateMaterialDialog> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController categoryController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.material.name ?? "",
    );

    descriptionController = TextEditingController(
      text: widget.material.description ?? "",
    );

    categoryController = TextEditingController(
      text: widget.material.category ?? "",
    );

    priceController = TextEditingController(
      text: widget.material.price ?? "",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _submit() {
    final entity = UpdateMaterialEntity(
      id: widget.material.id!,

      name: nameController.text.trim().isEmpty
          ? widget.material.name
          : nameController.text.trim(),

      description: descriptionController.text.trim().isEmpty
          ? widget.material.description
          : descriptionController.text.trim(),

      category: categoryController.text.trim().isEmpty
          ? widget.material.category
          : categoryController.text.trim(),

      price: priceController.text.trim().isEmpty
          ? double.tryParse(widget.material.price ?? "0")
          : double.tryParse(priceController.text.trim()),
    );

    context.read<UpdateMaterialsBloc>().add(
          UpdateMaterialRequested(
            parameters: entity,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<
        UpdateMaterialsBloc,
        UpdateMaterialsState>(
      listener: (context, state) {
       if (state.success) {
  AppSnackbarHelper.showSuccess(
    context,
    title: "تم التعديل",
    message: "تم تعديل المادة بنجاح",
  );

  context.read<ShowMaterialsBloc>().add(
    const ShowMaterialsRefresh(),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          "تعديل المادة",
        ),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _Field(
                  controller: nameController,
                  label: "اسم المادة",
                ),

                const SizedBox(height: 14),

                _Field(
                  controller: descriptionController,
                  label: "الوصف",
                  maxLines: 3,
                ),

                const SizedBox(height: 14),

                _Field(
                  controller: categoryController,
                  label: "التصنيف",
                ),

                const SizedBox(height: 14),

                _Field(
                  controller: priceController,
                  label: "السعر",
                  keyboardType: TextInputType.number,
                ),
              ],
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

          BlocBuilder<
              UpdateMaterialsBloc,
              UpdateMaterialsState>(
            builder: (context, state) {
              return FilledButton(
                onPressed:
                    state.isLoading ? null : _submit,
                child: state.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
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

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
        ),
      ),
    );
  }
}