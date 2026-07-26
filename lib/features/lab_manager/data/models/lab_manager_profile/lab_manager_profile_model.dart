import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lab_manager_profile_model.g.dart';

@JsonSerializable(createToJson: false)
class LabManagerProfileResponse extends Equatable {
   const LabManagerProfileResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final DataInProfile? data;
    final dynamic errors;

    factory LabManagerProfileResponse.fromJson(Map<String, dynamic> json) => _$LabManagerProfileResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class DataInProfile extends Equatable {
    const DataInProfile({
        required this.token,
        required this.user,
        required this.roles,
        required this.labId,
        required this.departments,
    });

    final String? token;
    final UserInProfile? user;
    final List<String>? roles;

    @JsonKey(name: 'lab_id') 
    final int? labId;
    final List<DepartmentInProfile>? departments;

    factory DataInProfile.fromJson(Map<String, dynamic> json) => _$DataInProfileFromJson(json);

    @override
    List<Object?> get props => [
    token, user, roles, labId, departments, ];
}

@JsonSerializable(createToJson: false)
class DepartmentInProfile extends Equatable {
    const DepartmentInProfile({
        required this.id,
        required this.name,
        required this.labId,
    });

    final int? id;
    final String? name;

    @JsonKey(name: 'lab_id') 
    final int? labId;

    factory DepartmentInProfile.fromJson(Map<String, dynamic> json) => _$DepartmentInProfileFromJson(json);

    @override
    List<Object?> get props => [
    id, name, labId, ];
}

@JsonSerializable(createToJson: false)
class UserInProfile extends Equatable {
    const UserInProfile({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.profileImage,
        required this.birthdate,
        required this.joinedAt,
        required this.location,
        required this.locationLat,
        required this.locationLng,
    });

    final int? id;
    final String? name;
    final String? email;
    final String? phone;

    @JsonKey(name: 'profile_image') 
    final dynamic profileImage;
    final dynamic birthdate;

    @JsonKey(name: 'joined_at') 
    final DateTime? joinedAt;
    final dynamic location;

    @JsonKey(name: 'location_lat') 
    final String? locationLat;

    @JsonKey(name: 'location_lng') 
    final String? locationLng;

    factory UserInProfile.fromJson(Map<String, dynamic> json) => _$UserInProfileFromJson(json);

    @override
    List<Object?> get props => [
    id, name, email, phone, profileImage, birthdate, joinedAt, location, locationLat, locationLng, ];
}
