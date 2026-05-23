// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedLabsResponseModel _$PaginatedLabsResponseModelFromJson(
  Map<String, dynamic> json,
) => PaginatedLabsResponseModel(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PaginatedLabsPageModel.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

PaginatedLabsPageModel _$PaginatedLabsPageModelFromJson(
  Map<String, dynamic> json,
) => PaginatedLabsPageModel(
  currentPage: (json['current_page'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => LabModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstPageUrl: json['first_page_url'] as String?,
  from: (json['from'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  lastPageUrl: json['last_page_url'] as String?,
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
      .toList(),
  nextPageUrl: json['next_page_url'],
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  prevPageUrl: json['prev_page_url'],
  to: (json['to'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

LabModel _$LabModelFromJson(Map<String, dynamic> json) => LabModel(
  id: (json['id'] as num?)?.toInt(),
  labName: json['lab_name'] as String?,
  licenseNumber: json['license_number'],
  location: json['location'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  rating: json['rating'] as String?,
  photo: json['photo'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  manager: json['manager'] == null
      ? null
      : LabManagerModel.fromJson(json['manager'] as Map<String, dynamic>),
);

LabManagerModel _$LabManagerModelFromJson(Map<String, dynamic> json) =>
    LabManagerModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
  url: json['url'] as String?,
  label: json['label'] as String?,
  page: (json['page'] as num?)?.toInt(),
  active: json['active'] as bool?,
);
