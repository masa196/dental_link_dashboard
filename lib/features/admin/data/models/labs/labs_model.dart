import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'labs_model.g.dart';

@JsonSerializable(createToJson: false)
class PaginatedLabsResponseModel extends Equatable {
  const PaginatedLabsResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final int? status;
  final String? message;
  final PaginatedLabsPageModel? data;
  final dynamic errors;

  factory PaginatedLabsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatedLabsResponseModelFromJson(json);

  @override
  List<Object?> get props => [success, status, message, data, errors];
}

@JsonSerializable(createToJson: false)
class PaginatedLabsPageModel extends Equatable {
  const PaginatedLabsPageModel({
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
  final List<LabModel>? data;

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

  factory PaginatedLabsPageModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatedLabsPageModelFromJson(json);

  @override
  List<Object?> get props => [
    currentPage,
    data,
    firstPageUrl,
    from,
    lastPage,
    lastPageUrl,
    links,
    nextPageUrl,
    path,
    perPage,
    prevPageUrl,
    to,
    total,
  ];
}

@JsonSerializable(createToJson: false)
class LabModel extends Equatable {
  const LabModel({
    required this.id,
    required this.labName,
    required this.licenseNumber,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.phone,
    required this.address,
    required this.rating,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.manager,
  });

  final int? id;

  @JsonKey(name: 'lab_name')
  final String? labName;

  @JsonKey(name: 'license_number')
  final dynamic licenseNumber;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? phone;
  final String? address;
  final String? rating;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final LabManagerModel? manager;

  factory LabModel.fromJson(Map<String, dynamic> json) =>
      _$LabModelFromJson(json);

  @override
  List<Object?> get props => [
    id,
    labName,
    licenseNumber,
    location,
    latitude,
    longitude,
    name,
    phone,
    address,
    rating,
    photo,
    createdAt,
    updatedAt,
    manager,
  ];
}

@JsonSerializable(createToJson: false)
class LabManagerModel extends Equatable {
  const LabManagerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  factory LabManagerModel.fromJson(Map<String, dynamic> json) =>
      _$LabManagerModelFromJson(json);

  @override
  List<Object?> get props => [id, name, email, phone];
}

@JsonSerializable(createToJson: false)
class Link extends Equatable {
  const Link({
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
  List<Object?> get props => [url, label, page, active];
}

extension LabModelPresentation on LabModel {
  int get safeId => id ?? 0;

  String get displayName {
    final value = labName?.trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    final fallback = name?.trim();

    if (fallback != null && fallback.isNotEmpty) {
      return fallback;
    }

    return 'Lab #$safeId';
  }

  String get displayCode {
    final value = licenseNumber?.toString().trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    return 'Lab #$safeId';
  }

  String get displayManagerName {
    final value = manager?.name?.trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    return '—';
  }

  String get displayPhone {
    final value = phone?.trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    return '—';
  }

  String get displayAddress {
    final value = address?.trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    return '—';
  }

  String get displayEmail {
    final value = manager?.email?.trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    return '—';
  }

  String? get displayPhotoUrl {
    final value = photo?.trim();

    if (value != null && value.isNotEmpty) {
      return value;
    }

    return null;
  }
}
