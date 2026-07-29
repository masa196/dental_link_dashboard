import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/delete_package/delete_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/delete_package/delete_package_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/delete_package/delete_package_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_event.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePackageDialog extends StatelessWidget {
  const DeletePackageDialog({super.key, required this.package});

  final PackageItemModel package;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeletePackageBloc, DeletePackageState>(
      listener: (context, state) {
        if (state.success) {
          AppSnackbarHelper.showSuccess(
            context,
            title: "تم الحذف",
            message: state.message ?? "تم حذف الباقة بنجاح",
          );

          context.read<ShowPackagesBloc>().add(const ShowPackagesRefresh());

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
        title: const Text("حذف الباقة"),

        content: Text("هل أنت متأكد من حذف باقة\n\n${package.name}"),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("إلغاء"),
          ),

          BlocBuilder<DeletePackageBloc, DeletePackageState>(
            builder: (context, state) {
              return FilledButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        context.read<DeletePackageBloc>().add(
                          DeletePackageRequested(packageId: package.id!),
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
