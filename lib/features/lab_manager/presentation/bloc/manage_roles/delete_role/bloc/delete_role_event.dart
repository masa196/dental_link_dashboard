import 'package:equatable/equatable.dart';

abstract class DeleteRoleEvent extends Equatable {
  const DeleteRoleEvent();

  @override
  List<Object?> get props => [];
}

class SubmitDeleteRoleEvent extends DeleteRoleEvent {
  final int roleId;

  const SubmitDeleteRoleEvent(this.roleId);

  @override
  List<Object?> get props => [roleId];
}

class ResetDeleteRoleState extends DeleteRoleEvent {
  const ResetDeleteRoleState();
}