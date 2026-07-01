import 'package:equatable/equatable.dart';

abstract class RolesEvent extends Equatable {
  const RolesEvent();

  @override
  List<Object?> get props => [];
}

class RolesFetchRequested extends RolesEvent {
  const RolesFetchRequested();
}
