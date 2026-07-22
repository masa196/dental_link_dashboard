import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/add_materials/add_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/show_materials/show_materials_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_materials/update_materials/update_materials_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/materials_view.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          lazy: false,
          create: (_) =>
              locator<ShowMaterialsBloc>()
                ..add(const ShowMaterialsRequested()),
        ),

        BlocProvider(
          create: (_) =>
              locator<AddMaterialsBloc>(),
        ),

         BlocProvider(
          create: (_) =>
              locator<UpdateMaterialsBloc>(),
        ),

      ],

      child: const MaterialsView(
        mode: MaterialsMode.manager,
      ),
    );
  }
}