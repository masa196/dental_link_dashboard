import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/add_material_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AddMaterialsEvent extends Equatable {
  const AddMaterialsEvent();

  @override
  List<Object?> get props => [];
}


class AddMaterialRequested extends AddMaterialsEvent {
  const AddMaterialRequested({
    required this.parameters,
  });

  final AddMaterialEntity parameters;

  @override
  List<Object?> get props => [
    parameters,
  ];
}