import 'dart:typed_data';

import 'package:dental_link_dashboard/features/admin/domain/entities/location/location_entity.dart';

class EditLabManagerEntity {
  final int labId;
  final String labName;
  final String managerName;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;
  final Uint8List? photo;
  final String? photoName;
  final LocationEntity? location;

  const EditLabManagerEntity({
    required this.labId,
    required this.labName,
    required this.managerName,
    required this.email,
    required this.phone,
    this.password = '',
    this.passwordConfirmation = '',
    this.photo,
    this.photoName,
    this.location,
  });

  bool get hasPassword =>
      password.trim().isNotEmpty || passwordConfirmation.trim().isNotEmpty;

  EditLabManagerEntity copyWith({
    int? labId,
    String? labName,
    String? managerName,
    String? email,
    String? phone,
    String? password,
    String? passwordConfirmation,
    Uint8List? photo,
    String? photoName,
    LocationEntity? location,
  }) {
    return EditLabManagerEntity(
      labId: labId ?? this.labId,
      labName: labName ?? this.labName,
      managerName: managerName ?? this.managerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      photo: photo ?? this.photo,
      photoName: photoName ?? this.photoName,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lab_name': labName.trim(),
      'manager_name': managerName.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      if (password.trim().isNotEmpty) 'password': password.trim(),
      if (passwordConfirmation.trim().isNotEmpty)
      'password_confirmation': passwordConfirmation.trim(),
      'address': location?.name,
      'latitude': location?.lat,
      'longitude': location?.lng,
    };
  }
}
