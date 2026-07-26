import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:equatable/equatable.dart';

class UpdateOrderDeliveryTimeState extends Equatable {
  const UpdateOrderDeliveryTimeState({
    this.response,
    this.failure,
    this.isLoading = false,
    this.isSuccess = false,
  });

  final OrderDeliveryTimeResponse? response;

  final AppFailure? failure;

  final bool isLoading;

  final bool isSuccess;

  UpdateOrderDeliveryTimeState copyWith({
    OrderDeliveryTimeResponse? response,
    AppFailure? failure,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return UpdateOrderDeliveryTimeState(
      response: response ?? this.response,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        response,
        failure,
        isLoading,
        isSuccess,
      ];
}