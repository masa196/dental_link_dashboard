import 'package:equatable/equatable.dart';

abstract class GetAllPermissionsEvent extends Equatable {
  const GetAllPermissionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllPermissions extends GetAllPermissionsEvent {
  const LoadAllPermissions();
}