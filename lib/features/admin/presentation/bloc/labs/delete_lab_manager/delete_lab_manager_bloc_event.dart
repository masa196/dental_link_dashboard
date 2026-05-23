import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/delete_lab_manager/delete_lab_manager_entity.dart';

abstract class DeleteLabManagerBlocEvent extends Equatable {
  const DeleteLabManagerBlocEvent();

  @override
  List<Object?> get props => [];
}

class DeleteLabManagerSubmitted extends DeleteLabManagerBlocEvent {
  const DeleteLabManagerSubmitted({required this.params});

  final DeleteLabManagerEntity params;

  @override
  List<Object?> get props => [params];
}

class DeleteLabManagerReset extends DeleteLabManagerBlocEvent {
  const DeleteLabManagerReset();
}
