import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/create_role_entity/create_role_entity.dart';

abstract class CreateRoleEvent extends Equatable {
  const CreateRoleEvent();

  @override
  List<Object?> get props => [];
}

class SubmitCreateRoleEvent extends CreateRoleEvent {
  final CreateRoleEntity params;

  const SubmitCreateRoleEvent(this.params);

  @override
  List<Object?> get props => [params];
}