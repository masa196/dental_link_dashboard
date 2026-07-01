import 'package:equatable/equatable.dart';

abstract class DeleteEmployeeBlocEvent extends Equatable {
  const DeleteEmployeeBlocEvent();

  @override
  List<Object?> get props => [];
}

class DeleteEmployeeSubmitted extends DeleteEmployeeBlocEvent {
  const DeleteEmployeeSubmitted({required this.employeeId});

  final int employeeId;

  @override
  List<Object?> get props => [employeeId];
}

class DeleteEmployeeReset extends DeleteEmployeeBlocEvent {
  const DeleteEmployeeReset();
}
