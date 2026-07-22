import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';

enum ShowOrderDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class ShowOrderDetailsState extends Equatable {
  const ShowOrderDetailsState({
    this.status = ShowOrderDetailsStatus.initial,
    this.response,
    this.failure,
  });

  final ShowOrderDetailsStatus status;
  final OrderDetailsResponse? response;
  final AppFailure? failure;

  ShowOrderDetailsState copyWith({
    ShowOrderDetailsStatus? status,
    OrderDetailsResponse? response,
    AppFailure? failure,
  }) {
    return ShowOrderDetailsState(
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