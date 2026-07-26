import 'package:equatable/equatable.dart';

class OrderDeliveryTimeEntity extends Equatable {
  final int normalDeliveryDays;
  final int urgentDeliveryDays;

  const OrderDeliveryTimeEntity({
    required this.normalDeliveryDays,
    required this.urgentDeliveryDays,
  });

  Map<String, dynamic> toJson() {
    return {
      "normal_delivery_days": normalDeliveryDays,
      "urgent_delivery_days": urgentDeliveryDays,
    };
  }

  @override
  List<Object> get props => [
        normalDeliveryDays,
        urgentDeliveryDays,
      ];
}