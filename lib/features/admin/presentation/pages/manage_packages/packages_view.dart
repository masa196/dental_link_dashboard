import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/add_package/add_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/delete_package/delete_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/update_package/update_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/dialogs/add_package_dialog.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/dialogs/delete_package_dialog.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/dialogs/my_package_dialog.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/dialogs/update_package_dialog.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/packages_page.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/widgets/packages_grid.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/get_package_assigned/get_package_assigned_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/get_package_assigned/get_package_assigned_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_header.dart';
import 'package:dental_link_dashboard/shared/pagination/floating_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackagesView extends StatelessWidget {
  const PackagesView({
    super.key,
    required this.mode,
  });

  final PackagesPageMode mode;

  bool get isAdmin => mode == PackagesPageMode.admin;

  void _showAddDialog(BuildContext context) {
    if (!isAdmin) return;

    showDialog(
      context: context,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<AddPackageBloc>(),
            ),
            BlocProvider.value(
              value: context.read<ShowPackagesBloc>(),
            ),
          ],
          child: const AddPackageDialog(),
        );
      },
    );
  }

  void _showMyPackageDialog(BuildContext context) {
    if (isAdmin) return;

    final bloc = context.read<GetPackageAssignedBloc>();

    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: bloc,
          child: const MyPackageDialog(),
        );
      },
    );

    bloc.add(
      const GetPackageAssignedRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowPackagesBloc, ShowPackagesState>(
      builder: (context, state) {
        if (state.isLoading && state.packages.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.failure != null) {
          return Center(
            child: Text(state.failure!.message),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallHeight = constraints.maxHeight < 350;

            Widget content = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  PackagesGrid(
                    packages: state.packages,
                    mode: mode,
                    onEdit: isAdmin
                        ? (package) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: context
                                          .read<UpdatePackageBloc>(),
                                    ),
                                    BlocProvider.value(
                                      value: context
                                          .read<ShowPackagesBloc>(),
                                    ),
                                  ],
                                  child: UpdatePackageDialog(
                                    package: package,
                                  ),
                                );
                              },
                            );
                          }
                        : null,
                    onDelete: isAdmin
                        ? (package) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: context
                                          .read<DeletePackageBloc>(),
                                    ),
                                    BlocProvider.value(
                                      value: context
                                          .read<ShowPackagesBloc>(),
                                    ),
                                  ],
                                  child: DeletePackageDialog(
                                    package: package,
                                  ),
                                );
                              },
                            );
                          }
                        : null,
                  ),

                  if (state.isLoading) ...[
                    const SizedBox(height: 20),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],

                  if (state.lastPage > 1) ...[
                    const SizedBox(height: 28),

                    FloatingPagination(
                      currentPage: state.currentPage,
                      totalPages: state.lastPage,
                      onPageChanged: state.isLoading
                          ? (_) {}
                          : (page) {
                              context
                                  .read<ShowPackagesBloc>()
                                  .add(
                                    ShowPackagesRequested(
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
                      title: "إدارة الباقات",

                      // Admin -> إضافة باقة
                      // Lab Manager -> عرض باقتي
                      addButtonLabel:
                          isAdmin ? "إضافة باقة" : "عرض باقتي",

                      showAddButton: true,

                      onAdd: isAdmin
                          ? () => _showAddDialog(context)
                          : () => _showMyPackageDialog(context),

                      onSearch: (value) {
                        context
                            .read<ShowPackagesBloc>()
                            .add(
                              ShowPackagesRequested(
                                page: 1,
                                search: value,
                              ),
                            );
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
                  title: "إدارة الباقات",

                  // Admin -> إضافة باقة
                  // Lab Manager -> عرض باقتي
                  addButtonLabel:
                      isAdmin ? "إضافة باقة" : "عرض باقتي",

                  showAddButton: true,

                  onAdd: isAdmin
                      ? () => _showAddDialog(context)
                      : () => _showMyPackageDialog(context),

                  onSearch: (value) {
                    context
                        .read<ShowPackagesBloc>()
                        .add(
                          ShowPackagesRequested(
                            page: 1,
                            search: value,
                          ),
                        );
                  },
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: content,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}