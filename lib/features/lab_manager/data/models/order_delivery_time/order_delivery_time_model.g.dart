// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_delivery_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDeliveryTimeResponse _$OrderDeliveryTimeResponseFromJson(
  Map<String, dynamic> json,
) => OrderDeliveryTimeResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : OrderDeliveryTimeModel.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

OrderDeliveryTimeModel _$OrderDeliveryTimeModelFromJson(
  Map<String, dynamic> json,
) => OrderDeliveryTimeModel(
  labId: (json['lab_id'] as num?)?.toInt(),
  normalDeliveryDays: (json['normal_delivery_days'] as num?)?.toInt(),
  urgentDeliveryDays: (json['urgent_delivery_days'] as num?)?.toInt(),
);
