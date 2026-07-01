import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/show_employee/show_employee_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_pagination_entity.dart';

enum EmployeePageStatus { initial, loading, success, failure }

class EmployeePageState extends Equatable {
  const EmployeePageState({
    this.status = EmployeePageStatus.initial,
    this.response,
    this.failure,
    required this.departmentId,
    this.departmentName,
    this.currentPage = 1,
    this.employeesPerPage = 15,
  });

  final EmployeePageStatus status;
  final ShowEmployeeResponse? response;
  final AppFailure? failure;
  final int departmentId;
  final String? departmentName;
  final int currentPage;
  final int employeesPerPage;

  List<EmployeesDatum> get employees =>
      response?.data?.department?.employees?.data ?? const [];

  EmployeePaginationEntity? get pagination {
    final meta = response?.data?.department?.employees?.meta;
    if (meta == null) return null;

    return EmployeePaginationEntity(
      departmentId: departmentId,
      employeesPerPage: employeesPerPage,
      employeesPage: currentPage,
      currentPage: meta.currentPage,
      lastPage: meta.lastPage,
      perPage: meta.perPage,
      total: meta.total,
      from: meta.from,
      to: meta.to,
    );
  }

  String get title =>
      response?.data?.department?.name ?? departmentName ?? 'Employees';

  int? get totalEmployees {
    if (status == EmployeePageStatus.loading && response == null) {
      return null;
    }

    return pagination?.total ?? employees.length;
  }

  bool get hasData => employees.isNotEmpty;

  bool get isLoading => status == EmployeePageStatus.loading;

  bool get isInitialLoading => isLoading && response == null;

  bool get hasPreviousPage => pagination?.hasPreviousPage ?? currentPage > 1;

  bool get hasNextPage => pagination?.hasNextPage ?? false;

  EmployeePageState copyWith({
    EmployeePageStatus? status,
    ShowEmployeeResponse? response,
    AppFailure? failure,
    bool clearFailure = false,
    String? departmentName,
    int? currentPage,
    int? employeesPerPage,
  }) {
    return EmployeePageState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: clearFailure ? null : (failure ?? this.failure),
      departmentId: departmentId,
      departmentName: departmentName ?? this.departmentName,
      currentPage: currentPage ?? this.currentPage,
      employeesPerPage: employeesPerPage ?? this.employeesPerPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    response,
    failure,
    departmentId,
    departmentName,
    currentPage,
    employeesPerPage,
  ];
}
