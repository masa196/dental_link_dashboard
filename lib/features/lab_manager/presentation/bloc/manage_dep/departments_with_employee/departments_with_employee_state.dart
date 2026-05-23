import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/departments_with_employee/departments_with_employee.dart';

enum DepartmentsWithEmployeeStatus { initial, loading, success, failure }

class DepartmentsWithEmployeeState extends Equatable {
  const DepartmentsWithEmployeeState({
    this.status = DepartmentsWithEmployeeStatus.initial,
    this.response,
    this.failure,
  });

  final DepartmentsWithEmployeeStatus status;
  final DepartmentsWithEmployeeResponse? response;
  final AppFailure? failure;

  List<DepartmentItem> get departments => response?.data?.data ?? const [];

  bool get hasData => departments.isNotEmpty;

  bool get isLoading => status == DepartmentsWithEmployeeStatus.loading;

  bool get isInitialLoading => isLoading && response == null;

  DepartmentsWithEmployeeState copyWith({
    DepartmentsWithEmployeeStatus? status,
    DepartmentsWithEmployeeResponse? response,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return DepartmentsWithEmployeeState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, response, failure];
}
