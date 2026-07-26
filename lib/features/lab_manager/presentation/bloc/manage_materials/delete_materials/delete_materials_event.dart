import 'package:equatable/equatable.dart';

sealed class DeleteMaterialsEvent extends Equatable {
  const DeleteMaterialsEvent();

  @override
  List<Object?> get props => [];
}

class DeleteMaterialRequested extends DeleteMaterialsEvent {
  const DeleteMaterialRequested({
    required this.materialId,
  });

  final int materialId;

  @override
  List<Object?> get props => [materialId];
}