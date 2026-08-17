// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_history_sys_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageHistoryInSysAdminResponse _$PackageHistoryInSysAdminResponseFromJson(
  Map<String, dynamic> json,
) => PackageHistoryInSysAdminResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  currentPage: (json['current_page'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
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

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  id: (json['id'] as num?)?.toInt(),
  labId: (json['lab_id'] as num?)?.toInt(),
  packageId: (json['package_id'] as num?)?.toInt(),
  assignedBy: json['assigned_by'] == null
      ? null
      : AssignedBy.fromJson(json['assigned_by'] as Map<String, dynamic>),
  assignedAt: json['assigned_at'] == null
      ? null
      : DateTime.parse(json['assigned_at'] as String),
  unassignedAt: json['unassigned_at'] == null
      ? null
      : DateTime.parse(json['unassigned_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  package: json['package'] == null
      ? null
      : PackageItemInSysAdmin.fromJson(json['package'] as Map<String, dynamic>),
);

AssignedBy _$AssignedByFromJson(Map<String, dynamic> json) => AssignedBy(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  emailVerifiedAt: json['email_verified_at'],
  labName: json['lab_name'],
  failedLoginAttempts: (json['failed_login_attempts'] as num?)?.toInt(),
  lockedUntil: json['locked_until'],
  profileImage: json['profile_image'],
  birthdate: json['birthdate'],
  joinedAt: json['joined_at'],
  location: json['location'] as String?,
  locationLat: json['location_lat'] as String?,
  locationLng: json['location_lng'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

PackageItemInSysAdmin _$PackageItemInSysAdminFromJson(
  Map<String, dynamic> json,
) => PackageItemInSysAdmin(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  durationDays: (json['duration_days'] as num?)?.toInt(),
  price: json['price'] as String?,
  isActive: json['is_active'] as bool?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
  url: json['url'] as String?,
  label: json['label'] as String?,
  page: (json['page'] as num?)?.toInt(),
  active: json['active'] as bool?,
);
