
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/matrix_roles_entity/matrix_roles_entity.dart';
import 'package:equatable/equatable.dart';

class UpdateMatrixRolesAndPermissonsEvent extends Equatable {
  const UpdateMatrixRolesAndPermissonsEvent();

  @override
  List<Object?> get props => [];
}

class SubmitMatrixEvent extends UpdateMatrixRolesAndPermissonsEvent {
  final MatrixRolesEntity params;

  const SubmitMatrixEvent(this.params);

  @override
  List<Object?> get props => [params];
}