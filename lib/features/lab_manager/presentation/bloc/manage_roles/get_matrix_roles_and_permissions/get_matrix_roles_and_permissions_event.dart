import 'package:equatable/equatable.dart';

sealed class GetMatrixRolesAndPermissionsEvent extends Equatable {
  const GetMatrixRolesAndPermissionsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadMatrixRolesAndPermissions
    extends GetMatrixRolesAndPermissionsEvent {
  const LoadMatrixRolesAndPermissions();
}

final class RefreshMatrixRolesAndPermissions
    extends GetMatrixRolesAndPermissionsEvent {
  const RefreshMatrixRolesAndPermissions();
}