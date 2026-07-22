// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_materials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowMaterialsResponse _$ShowMaterialsResponseFromJson(
  Map<String, dynamic> json,
) => ShowMaterialsResponse(
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
      ?.map((e) => MaterialItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num?)?.toInt(),
  perPage: (json['per_page'] as num?)?.toInt(),
  currentPage: (json['current_page'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
);

MaterialItem _$MaterialItemFromJson(Map<String, dynamic> json) => MaterialItem(
  id: (json['id'] as num?)?.toInt(),
  labId: (json['lab_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  category: json['category'] as String?,
  price: json['price'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);
