import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/add_materials/add_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/delete_materials/delete_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/update_materials/update_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/dialogs/add_material_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/dialogs/delete_material_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/dialogs/update_material_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_grid.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_header.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_mode.dart';
import 'package:dental_link_dashboard/shared/pagination/floating_pagination.dart';
import 'package:dental_link_dashboard/notifications/presentation/widgets/notifications_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialsView extends StatelessWidget {
  const MaterialsView({super.key, required this.mode});

  final MaterialsMode mode;

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<AddMaterialsBloc>()),
            BlocProvider.value(value: context.read<ShowMaterialsBloc>()),
          ],
          child: const AddMaterialDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowMaterialsBloc, ShowMaterialsState>(
      builder: (context, state) {
        if (state.isLoading && state.materials.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.failure != null) {
          return Center(child: Text(state.failure!.message));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallHeight = constraints.maxHeight < 350;

            Widget content = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  MaterialsGrid(
                    materials: state.materials,
                    mode: mode,

                    onEdit: (material) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<UpdateMaterialsBloc>(),
                              ),

                              BlocProvider.value(
                                value: context.read<ShowMaterialsBloc>(),
                              ),
                            ],

                            child: UpdateMaterialDialog(material: material),
                          );
                        },
                      );
                    },
                    onDelete: (material) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<DeleteMaterialsBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<ShowMaterialsBloc>(),
                              ),
                            ],
                            child: DeleteMaterialDialog(material: material),
                          );
                        },
                      );
                    },
                  ),

                  if (state.isLoading) ...[
                    const SizedBox(height: 20),
                    const Center(child: CircularProgressIndicator()),
                  ],

                  if (state.lastPage > 1) ...[
                    const SizedBox(height: 28),

                    FloatingPagination(
                      currentPage: state.currentPage,
                      totalPages: state.lastPage,

                      onPageChanged: state.isLoading
                          ? (_) {}
                          : (page) {
                              context.read<ShowMaterialsBloc>().add(
                                ShowMaterialsRequested(
                                  page: page,
                                  search: state.currentSearch,
                                ),
                              );
                            },
                    ),
                  ],

                  const SizedBox(height: 30),
                ],
              ),
            );

            if (isSmallHeight) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialsHeader(
                      title: "إدارة المواد",
                      hintText:"ابحث عن طريق اسم المادة أو نوعها",
                      showAddButton: mode.canEdit,

                      onAdd: () => _showAddDialog(context),

                      onSearch: (value) {
                        context.read<ShowMaterialsBloc>().add(
                          ShowMaterialsRequested(page: 1, search: value),
                        );
                      },
                       onNotificationTap: mode.canEdit
                      ? null
                      : () {
                          NotificationsDialog.show(context);
                        },
                    ),
                    content,
                  ],
                ),
              );
            }

            return Column(
              children: [
                MaterialsHeader(
                  
                  title: "إدارة المواد",
                    hintText: "ابحث عن طريق اسم المادة أو نوعها",

                  showAddButton: mode.canEdit,

                  onAdd: () => _showAddDialog(context),

                  onSearch: (value) {
                    context.read<ShowMaterialsBloc>().add(
                      ShowMaterialsRequested(page: 1, search: value),
                    );
                  },
                  onNotificationTap: mode.canEdit
                      ? null
                      : () {
                          NotificationsDialog.show(context);
                        },
                 
                ),

                Expanded(child: SingleChildScrollView(child: content)),
              ],
            );
          },
        );
      },
    );
  }
}
