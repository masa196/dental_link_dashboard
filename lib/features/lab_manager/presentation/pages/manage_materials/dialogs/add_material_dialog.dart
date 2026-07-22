import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/add_material_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/add_materials/add_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/add_materials/add_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/add_materials/add_materials_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMaterialDialog extends StatefulWidget {
  const AddMaterialDialog({
    super.key,
  });

  @override
  State<AddMaterialDialog> createState() => _AddMaterialDialogState();
}

class _AddMaterialDialogState extends State<AddMaterialDialog> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode =
      AutovalidateMode.disabled;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();

    super.dispose();
  }

  void _submit() {

    setState(() {
      _autoValidateMode =
          AutovalidateMode.onUserInteraction;
    });


    if (!_formKey.currentState!.validate()) {
      return;
    }


    final entity = AddMaterialEntity(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      price: double.parse(
        priceController.text.trim(),
      ),
    );


    context.read<AddMaterialsBloc>().add(
      AddMaterialRequested(
        parameters: entity,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final scheme = Theme.of(context).colorScheme;


    return BlocListener<AddMaterialsBloc, AddMaterialsState>(
      listener: (context, state) {

        if (state.success) {

          AppSnackbarHelper.showSuccess(
            context,
            title: "تمت الإضافة",
            message: "تمت إضافة المادة بنجاح",
          );


          Navigator.pop(context);
        }


        if (state.failure != null) {

          AppSnackbarHelper.showFailure(
            context,
            title: "فشل الإضافة",
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
          "إضافة مادة جديدة",
        ),


        content: SizedBox(
          width: 420,


          child: Form(

            key: _formKey,

            autovalidateMode: _autoValidateMode,


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

                    keyboardType:
                        TextInputType.number,


                    validator: (value) {

                      if (value == null ||
                          value.trim().isEmpty) {

                        return "يرجى إدخال السعر";
                      }


                      if (double.tryParse(value) == null) {

                        return "السعر يجب أن يكون رقماً";
                      }


                      return null;
                    },
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

            child: const Text(
              "إلغاء",
            ),
          ),



          BlocBuilder<AddMaterialsBloc, AddMaterialsState>(

            builder: (context, state) {

              return FilledButton(

                onPressed:
                    state.isLoading
                        ? null
                        : _submit,


                child: state.isLoading

                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )

                    : const Text(
                        "إضافة",
                      ),
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
    this.validator,
  });


  final TextEditingController controller;

  final String label;

  final int maxLines;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;



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

            if (value == null ||
                value.trim().isEmpty) {

              return "يرجى إدخال $label";
            }


            return null;
          },


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