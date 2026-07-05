import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';

enum ShowDeliveryEmployeesStatus {
  initial,
  loading,
  success,
  failure,
}

class ShowDeliveryEmployeesState extends Equatable {
  final ShowDeliveryEmployeesStatus status;

  final DeliveryEmployeesResponse? response;

  final AppFailure? failure;

  const ShowDeliveryEmployeesState({
    this.status = ShowDeliveryEmployeesStatus.initial,
    this.response,
    this.failure,
  });

  ShowDeliveryEmployeesState copyWith({
    ShowDeliveryEmployeesStatus? status,
    DeliveryEmployeesResponse? response,
    AppFailure? failure,
  }) {
    return ShowDeliveryEmployeesState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        response,
        failure,
      ];
}