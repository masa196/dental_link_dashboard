import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/delete_materials/delete_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/delete_materials/delete_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/delete_materials/delete_materials_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteMaterialDialog extends StatelessWidget {
  const DeleteMaterialDialog({super.key, required this.material});

  final MaterialItem material;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteMaterialsBloc, DeleteMaterialsState>(
      listener: (context, state) {
        if (state.success) {
          AppSnackbarHelper.showSuccess(
            context,
            title: "تم الحذف",
            message: "تم حذف المادة بنجاح",
          );

          context.read<ShowMaterialsBloc>().add(const ShowMaterialsRefresh());

          Navigator.pop(context);
        }

        if (state.failure != null) {
          AppSnackbarHelper.showFailure(
            context,
            title: "فشل الحذف",
            message: state.failure!.message,
            failure: state.failure,
          );
        }
      },
      child: AlertDialog(
        title: const Text("حذف المادة"),

        content: Text("هل أنت متأكد من حذف المادة\n\n${material.name}"),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("إلغاء"),
          ),

          BlocBuilder<DeleteMaterialsBloc, DeleteMaterialsState>(
            builder: (context, state) {
              return FilledButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        context.read<DeleteMaterialsBloc>().add(
                          DeleteMaterialRequested(materialId: material.id!),
                        );
                      },
                child: state.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("حذف"),
              );
            },
          ),
        ],
      ),
    );
  }
}
