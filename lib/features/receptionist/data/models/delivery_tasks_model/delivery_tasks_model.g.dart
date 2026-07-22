// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_tasks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryTasksResponse _$DeliveryTasksResponseFromJson(
  Map<String, dynamic> json,
) => DeliveryTasksResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => TaskInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  links: json['links'] == null
      ? null
      : Links.fromJson(json['links'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) => TaskInfo(
  id: (json['id'] as num?)?.toInt(),
  orderId: (json['order_id'] as num?)?.toInt(),
  status: json['status'] as String?,
  direction: json['direction'] as String?,
  assignedAt: json['assigned_at'] == null
      ? null
      : DateTime.parse(json['assigned_at'] as String),
  deliveryUser: json['delivery_user'] == null
      ? null
      : DeliveryUser.fromJson(json['delivery_user'] as Map<String, dynamic>),
  doctorName: json['doctor_name'] as String?,
  doctorPhone: json['doctor_phone'] as String?,
  doctorLocation: json['doctor_location'] as String?,
  doctorLocationLat: json['doctor_location_lat'] as String?,
  doctorLocationLng: json['doctor_location_lng'] as String?,
);

DeliveryUser _$DeliveryUserFromJson(Map<String, dynamic> json) => DeliveryUser(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
  first: json['first'] as String?,
  last: json['last'] as String?,
  prev: json['prev'],
  next: json['next'] as String?,
);

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  currentPage: (json['current_page'] as num?)?.toInt(),
  from: (json['from'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
      .toList(),
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
  url: json['url'] as String?,
  label: json['label'] as String?,
  page: (json['page'] as num?)?.toInt(),
  active: json['active'] as bool?,
);
