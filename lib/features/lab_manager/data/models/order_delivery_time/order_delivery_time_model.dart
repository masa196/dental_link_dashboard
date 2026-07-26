import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_delivery_time_model.g.dart';

@JsonSerializable(createToJson: false)
class OrderDeliveryTimeResponse extends Equatable {
    const OrderDeliveryTimeResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final OrderDeliveryTimeModel? data;
    final dynamic errors;

    factory OrderDeliveryTimeResponse.fromJson(Map<String, dynamic> json) => _$OrderDeliveryTimeResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class OrderDeliveryTimeModel extends Equatable {
    const OrderDeliveryTimeModel({
        required this.labId,
        required this.normalDeliveryDays,
        required this.urgentDeliveryDays,
    });

    @JsonKey(name: 'lab_id') 
    final int? labId;

    @JsonKey(name: 'normal_delivery_days') 
    final int? normalDeliveryDays;

    @JsonKey(name: 'urgent_delivery_days') 
    final int? urgentDeliveryDays;

    factory OrderDeliveryTimeModel.fromJson(Map<String, dynamic> json) => _$OrderDeliveryTimeModelFromJson(json);

    @override
    List<Object?> get props => [
    labId, normalDeliveryDays, urgentDeliveryDays, ];
}
