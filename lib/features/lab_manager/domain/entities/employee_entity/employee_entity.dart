import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  const EmployeeEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.birthdate,
    required this.joinedAt,
    required this.departmentIds,
    required this.roleId,
    required this.phone,
    this.profileImageBytes,
    this.profileImageName,
    this.profileImagePath,
  });

  final int? id;
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String birthdate;
  final String joinedAt;
  final List<int> departmentIds;
  final int roleId;
  final String phone;
  final Uint8List? profileImageBytes;
  final String? profileImageName;
  final String? profileImagePath;

  bool get hasProfileImage =>
      profileImageBytes != null ||
      (profileImagePath != null && profileImagePath!.isNotEmpty);

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    password,
    passwordConfirmation,
    birthdate,
    joinedAt,
    departmentIds,
    roleId,
    phone,
    profileImageBytes,
    profileImageName,
    profileImagePath,
  ];
}
