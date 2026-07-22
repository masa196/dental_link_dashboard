import 'package:equatable/equatable.dart';

class EmployeePaginationEntity extends Equatable {
  const EmployeePaginationEntity({
    required this.departmentId,
    required this.employeesPerPage,
    required this.employeesPage,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
  });

  final int departmentId;
  final int employeesPerPage;
  final int employeesPage;
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;
  final int? from;
  final int? to;

  bool get hasPreviousPage => (currentPage ?? employeesPage) > 1;
  bool get hasNextPage =>
      (currentPage ?? employeesPage) <
      (lastPage ?? currentPage ?? employeesPage);

  @override
  List<Object?> get props => [
    departmentId,
    employeesPerPage,
    employeesPage,
    currentPage,
    lastPage,
    perPage,
    total,
    from,
    to,
  ];
}
