// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_manager_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabManagerProfileResponse _$LabManagerProfileResponseFromJson(
  Map<String, dynamic> json,
) => LabManagerProfileResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DataInProfile.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

DataInProfile _$DataInProfileFromJson(Map<String, dynamic> json) =>
    DataInProfile(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : UserInProfile.fromJson(json['user'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      labId: (json['lab_id'] as num?)?.toInt(),
      departments: (json['departments'] as List<dynamic>?)
          ?.map((e) => DepartmentInProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DepartmentInProfile _$DepartmentInProfileFromJson(Map<String, dynamic> json) =>
    DepartmentInProfile(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      labId: (json['lab_id'] as num?)?.toInt(),
    );

UserInProfile _$UserInProfileFromJson(Map<String, dynamic> json) =>
    UserInProfile(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profile_image'],
      birthdate: json['birthdate'],
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
      location: json['location'],
      locationLat: json['location_lat'] as String?,
      locationLng: json['location_lng'] as String?,
    );
