import 'package:equatable/equatable.dart';

abstract class DeleteDepartmentBlocEvent extends Equatable {
  const DeleteDepartmentBlocEvent();

  @override
  List<Object?> get props => [];
}

class DeleteDepartmentSubmitted extends DeleteDepartmentBlocEvent {
  const DeleteDepartmentSubmitted({required this.departmentId});

  final int departmentId;

  @override
  List<Object?> get props => [departmentId];
}

class DeleteDepartmentReset extends DeleteDepartmentBlocEvent {
  const DeleteDepartmentReset();
}
