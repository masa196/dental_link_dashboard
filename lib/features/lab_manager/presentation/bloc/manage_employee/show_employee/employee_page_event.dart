import 'package:equatable/equatable.dart';

abstract class EmployeePageEvent extends Equatable {
  const EmployeePageEvent();

  @override
  List<Object?> get props => [];
}

class EmployeePageFetchRequested extends EmployeePageEvent {
  const EmployeePageFetchRequested({
    required this.departmentId,
    required this.page,
    required this.employeesPerPage,
  });

  final int departmentId;
  final int page;
  final int employeesPerPage;

  @override
  List<Object?> get props => [departmentId, page, employeesPerPage];
}
