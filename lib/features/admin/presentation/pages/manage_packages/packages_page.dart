import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/add_package/add_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/delete_package/delete_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/update_package/update_package_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/packages_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PackagesPageMode {
  admin,
  labManager,
}

class PackagesPage extends StatelessWidget {
  const PackagesPage({
    super.key,
    this.mode = PackagesPageMode.admin,
  });

  final PackagesPageMode mode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) =>
              locator<ShowPackagesBloc>()
                ..add(const ShowPackagesRequested()),
        ),

        // هذه الـ Blocs نحتاجها فقط في وضع Admin
        if (mode == PackagesPageMode.admin)
          BlocProvider(
            create: (_) => locator<AddPackageBloc>(),
          ),

        if (mode == PackagesPageMode.admin)
          BlocProvider(
            create: (_) => locator<UpdatePackageBloc>(),
          ),

        if (mode == PackagesPageMode.admin)
          BlocProvider(
            create: (_) => locator<DeletePackageBloc>(),
          ),
      ],
      child: PackagesView(mode: mode),
    );
  }
}