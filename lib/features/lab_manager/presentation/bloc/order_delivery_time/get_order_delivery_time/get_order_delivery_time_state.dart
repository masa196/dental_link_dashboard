import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:equatable/equatable.dart';

class GetOrderDeliveryTimeState extends Equatable {
  const GetOrderDeliveryTimeState({
    this.deliveryTime,
    this.failure,
    this.isLoading = false,
  });

  final OrderDeliveryTimeModel? deliveryTime;

  final AppFailure? failure;

  final bool isLoading;

  GetOrderDeliveryTimeState copyWith({
    OrderDeliveryTimeModel? deliveryTime,
    AppFailure? failure,
    bool? isLoading,
  }) {
    return GetOrderDeliveryTimeState(
      deliveryTime: deliveryTime ?? this.deliveryTime,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        deliveryTime,
        failure,
        isLoading,
      ];
}