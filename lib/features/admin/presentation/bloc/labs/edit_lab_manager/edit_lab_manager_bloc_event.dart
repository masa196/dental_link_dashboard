import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/edit_lab_manager/edit_lab_manager_entity.dart';

abstract class EditLabManagerBlocEvent extends Equatable {
  const EditLabManagerBlocEvent();

  @override
  List<Object?> get props => [];
}

class EditLabManagerSubmitted extends EditLabManagerBlocEvent {
  final EditLabManagerEntity params;

  const EditLabManagerSubmitted({required this.params});

  @override
  List<Object?> get props => [params];
}

class EditLabManagerReset extends EditLabManagerBlocEvent {
  const EditLabManagerReset();
  
  
}