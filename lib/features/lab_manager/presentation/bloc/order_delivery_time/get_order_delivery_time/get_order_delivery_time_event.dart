
import 'package:equatable/equatable.dart';

abstract class GetOrderDeliveryTimeEvent extends Equatable {
  const GetOrderDeliveryTimeEvent();

  @override
  List<Object?> get props => [];
}

class GetOrderDeliveryTimeRequested extends GetOrderDeliveryTimeEvent {
  const GetOrderDeliveryTimeRequested();
}

class GetOrderDeliveryTimeRefresh extends GetOrderDeliveryTimeEvent {
  const GetOrderDeliveryTimeRefresh();
}