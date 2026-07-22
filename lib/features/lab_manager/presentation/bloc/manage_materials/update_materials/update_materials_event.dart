import 'package:dental_link_dashboard/features/lab_manager/domain/entities/materials_entity/update_material_entity.dart';
import 'package:equatable/equatable.dart';

sealed class UpdateMaterialsEvent extends Equatable {
  const UpdateMaterialsEvent();

  @override
  List<Object?> get props => [];
}

class UpdateMaterialRequested extends UpdateMaterialsEvent {
  const UpdateMaterialRequested({
    required this.parameters,
  });

  final UpdateMaterialEntity parameters;

  @override
  List<Object?> get props => [
        parameters,
      ];
}