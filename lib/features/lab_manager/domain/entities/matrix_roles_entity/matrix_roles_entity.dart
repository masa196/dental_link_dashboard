import 'package:equatable/equatable.dart';

class MatrixRolesEntity extends Equatable {
  final List<MatrixRoleItemEntity> matrix;

  const MatrixRolesEntity({
    required this.matrix,
  });

  @override
  List<Object?> get props => [matrix];
}

class MatrixRoleItemEntity extends Equatable {
  final int roleId;
  final List<int> permissions;

  const MatrixRoleItemEntity({
    required this.roleId,
    required this.permissions,
  });

  @override
  List<Object?> get props => [roleId, permissions];

  Map<String, dynamic> toJson() {
    return {
      "role_id": roleId,
      "permissions": permissions,
    };
  }
}