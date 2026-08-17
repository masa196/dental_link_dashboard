import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_history_sys_admin_model.g.dart';

@JsonSerializable(createToJson: false)
class PackageHistoryInSysAdminResponse extends Equatable {
const  PackageHistoryInSysAdminResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final Data? data;
    final dynamic errors;

    factory PackageHistoryInSysAdminResponse.fromJson(Map<String, dynamic> json) => _$PackageHistoryInSysAdminResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
    const Data({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    @JsonKey(name: 'current_page') 
    final int? currentPage;
    final List<Datum>? data;

    @JsonKey(name: 'first_page_url') 
    final String? firstPageUrl;
    final int? from;

    @JsonKey(name: 'last_page') 
    final int? lastPage;

    @JsonKey(name: 'last_page_url') 
    final String? lastPageUrl;
    final List<Link>? links;

    @JsonKey(name: 'next_page_url') 
    final dynamic nextPageUrl;
    final String? path;

    @JsonKey(name: 'per_page') 
    final int? perPage;

    @JsonKey(name: 'prev_page_url') 
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    currentPage, data, firstPageUrl, from, lastPage, lastPageUrl, links, nextPageUrl, path, perPage, prevPageUrl, to, total, ];
}

@JsonSerializable(createToJson: false)
class Datum extends Equatable {
    const Datum({
        required this.id,
        required this.labId,
        required this.packageId,
        required this.assignedBy,
        required this.assignedAt,
        required this.unassignedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.package,
    });

    final int? id;

    @JsonKey(name: 'lab_id') 
    final int? labId;

    @JsonKey(name: 'package_id') 
    final int? packageId;

    @JsonKey(name: 'assigned_by') 
    final AssignedBy? assignedBy;

    @JsonKey(name: 'assigned_at') 
    final DateTime? assignedAt;

    @JsonKey(name: 'unassigned_at') 
    final DateTime? unassignedAt;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;
    final PackageItemInSysAdmin? package;

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    @override
    List<Object?> get props => [
    id, labId, packageId, assignedBy, assignedAt, unassignedAt, createdAt, updatedAt, package, ];
}

@JsonSerializable(createToJson: false)
class AssignedBy extends Equatable {
    const AssignedBy({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.emailVerifiedAt,
        required this.labName,
        required this.failedLoginAttempts,
        required this.lockedUntil,
        required this.profileImage,
        required this.birthdate,
        required this.joinedAt,
        required this.location,
        required this.locationLat,
        required this.locationLng,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? email;
    final String? phone;

    @JsonKey(name: 'email_verified_at') 
    final dynamic emailVerifiedAt;

    @JsonKey(name: 'lab_name') 
    final dynamic labName;

    @JsonKey(name: 'failed_login_attempts') 
    final int? failedLoginAttempts;

    @JsonKey(name: 'locked_until') 
    final dynamic lockedUntil;

    @JsonKey(name: 'profile_image') 
    final dynamic profileImage;
    final dynamic birthdate;

    @JsonKey(name: 'joined_at') 
    final dynamic joinedAt;
    final String? location;

    @JsonKey(name: 'location_lat') 
    final String? locationLat;

    @JsonKey(name: 'location_lng') 
    final String? locationLng;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    factory AssignedBy.fromJson(Map<String, dynamic> json) => _$AssignedByFromJson(json);

    @override
    List<Object?> get props => [
    id, name, email, phone, emailVerifiedAt, labName, failedLoginAttempts, lockedUntil, profileImage, birthdate, joinedAt, location, locationLat, locationLng, createdAt, updatedAt, ];
}

@JsonSerializable(createToJson: false)
class PackageItemInSysAdmin extends Equatable {
    const PackageItemInSysAdmin({
        required this.id,
        required this.name,
        required this.description,
        required this.durationDays,
        required this.price,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? description;

    @JsonKey(name: 'duration_days') 
    final int? durationDays;
    final String? price;

    @JsonKey(name: 'is_active') 
    final bool? isActive;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    factory PackageItemInSysAdmin.fromJson(Map<String, dynamic> json) => _$PackageItemInSysAdminFromJson(json);

    @override
    List<Object?> get props => [
    id, name, description, durationDays, price, isActive, createdAt, updatedAt, ];
}

@JsonSerializable(createToJson: false)
class Link extends Equatable {
  const  Link({
        required this.url,
        required this.label,
        required this.page,
        required this.active,
    });

    final String? url;
    final String? label;
    final int? page;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

    @override
    List<Object?> get props => [
    url, label, page, active, ];
}
