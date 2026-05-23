import 'dart:typed_data';

import 'package:dental_link_dashboard/features/admin/domain/entities/location/location_entity.dart';

class CreateLabManagerEntity {
  final String? labName;
  final String? managerName;
  final String? phone;
  final String? email;
  final String? password;
  final bool? hidePassword;
  final bool? hideConfirm;
  final String? passwordConfirmation;
  final Uint8List? photo;
  final String? photoName;
  final LocationEntity? location;

  const CreateLabManagerEntity({
    this.labName,
    this.managerName,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.hidePassword,
    this.hideConfirm,
    this.photo,
    this.photoName,
    this.location,
  });

  CreateLabManagerEntity copyWith({
    String? labName,
    String? managerName,
    String? phone,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? otp,
    bool? hidePassword,
    bool? hideConfirm,
    bool? rememberMe,
    LocationEntity? location,
    Uint8List? photo,
    String? photoName,
  }) {
    return CreateLabManagerEntity(
      labName: labName ?? this.labName,
      managerName: managerName ?? this.managerName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      hidePassword: hidePassword ?? this.hidePassword,
      hideConfirm: hideConfirm ?? this.hideConfirm,
      location: location ?? this.location,
      photo: photo ?? this.photo,
      photoName: photoName ?? this.photoName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lab_name': labName,
      'manager_name': managerName,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'address': location?.name,
      'latitude': location?.lat,
      'longitude': location?.lng,
    };
  }
}
