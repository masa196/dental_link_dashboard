import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';

abstract class CreateLabManagerBlocEvent extends Equatable {
  const CreateLabManagerBlocEvent();

  @override
  List<Object?> get props => [];
}

class CreateLabManagerSubmitted extends CreateLabManagerBlocEvent {
  final CreateLabManagerEntity params;

  const CreateLabManagerSubmitted({required this.params});

  @override
  List<Object?> get props => [params];
}

class CreateLabManagerReset extends CreateLabManagerBlocEvent {
  const CreateLabManagerReset();
}
