import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseModel extends Equatable {
  const LoginResponseModel({
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

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  @override
  List<Object?> get props => [success, status, message, data, errors];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
  const Data({required this.token, required this.user, required this.roles});

  final String? token;
  final User? user;
  final List<String>? roles;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  @override
  List<Object?> get props => [token, user, roles];
}

@JsonSerializable(createToJson: false)
class User extends Equatable {
  const User({
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
  final String? location;

  @JsonKey(name: 'location_lat')
  final String? locationLat;

  @JsonKey(name: 'location_lng')
  final String? locationLng;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    profileImage,
    birthdate,
    joinedAt,
    location,
    locationLat,
    locationLng,
  ];
}
