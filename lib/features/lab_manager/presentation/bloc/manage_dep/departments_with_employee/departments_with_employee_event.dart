import 'package:equatable/equatable.dart';

abstract class DepartmentsWithEmployeeEvent extends Equatable {
  const DepartmentsWithEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class DepartmentsWithEmployeeFetchRequested
    extends DepartmentsWithEmployeeEvent {
  const DepartmentsWithEmployeeFetchRequested();
}
