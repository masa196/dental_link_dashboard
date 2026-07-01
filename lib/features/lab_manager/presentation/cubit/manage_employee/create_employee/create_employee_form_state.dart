import 'dart:typed_data';
import 'package:equatable/equatable.dart';


class CreateEmployeeFormState extends Equatable {
  const CreateEmployeeFormState({
    this.departmentIds = const [],
    this.roleId,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.birthdate = '',
    this.joinedAt = '',
    this.phone = '',
    this.profileImageBytes,
    this.profileImageName,
    this.profileImagePath,
    this.departmentError,
    this.roleError,
    this.profileImageError,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.birthdateError,
    this.joinedAtError,
    this.phoneError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  final List<int> departmentIds;
  final int? roleId;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String birthdate;
  final String joinedAt;
  final String phone;
  final Uint8List? profileImageBytes;
  final String? profileImageName;
  final String? profileImagePath;
  final String? departmentError;
  final String? roleError;
  final String? profileImageError;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? birthdateError;
  final String? joinedAtError;
  final String? phoneError;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  bool get hasProfileImage =>
      profileImageBytes != null ||
      (profileImagePath != null && profileImagePath!.isNotEmpty);

  CreateEmployeeFormState copyWith({
    List<int>? departmentIds,
    int? roleId,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? birthdate,
    String? joinedAt,
    String? phone,
    Uint8List? profileImageBytes,
    String? profileImageName,
    String? profileImagePath,
    String? departmentError,
    String? roleError,
    String? profileImageError,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? birthdateError,
    String? joinedAtError,
    String? phoneError,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool clearProfileImage = false,
    bool clearErrors = false,
    bool clearDepartmentError = false,
    bool clearRoleError = false,
    bool clearProfileImageError = false,
    bool clearNameError = false,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearConfirmPasswordError = false,
    bool clearBirthdateError = false,
    bool clearJoinedAtError = false,
    bool clearPhoneError = false,
  }) {
    return CreateEmployeeFormState(
      departmentIds: departmentIds ?? this.departmentIds,
      roleId: roleId ?? this.roleId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      birthdate: birthdate ?? this.birthdate,
      joinedAt: joinedAt ?? this.joinedAt,
      phone: phone ?? this.phone,
      profileImageBytes: clearProfileImage
          ? null
          : (profileImageBytes ?? this.profileImageBytes),
      profileImageName: clearProfileImage
          ? null
          : (profileImageName ?? this.profileImageName),
      profileImagePath: clearProfileImage
          ? null
          : (profileImagePath ?? this.profileImagePath),
      departmentError: clearErrors
          ? null
          : clearDepartmentError
          ? null
          : (departmentError ?? this.departmentError),
      roleError: clearErrors
          ? null
          : clearRoleError
          ? null
          : (roleError ?? this.roleError),
      profileImageError: clearErrors
          ? null
          : clearProfileImageError
          ? null
          : (profileImageError ?? this.profileImageError),
      nameError: clearErrors
          ? null
          : clearNameError
          ? null
          : (nameError ?? this.nameError),
      emailError: clearErrors
          ? null
          : clearEmailError
          ? null
          : (emailError ?? this.emailError),
      passwordError: clearErrors
          ? null
          : clearPasswordError
          ? null
          : (passwordError ?? this.passwordError),
      confirmPasswordError: clearErrors
          ? null
          : clearConfirmPasswordError
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
      birthdateError: clearErrors
          ? null
          : clearBirthdateError
          ? null
          : (birthdateError ?? this.birthdateError),
      joinedAtError: clearErrors
          ? null
          : clearJoinedAtError
          ? null
          : (joinedAtError ?? this.joinedAtError),
      phoneError: clearErrors
          ? null
          : clearPhoneError
          ? null
          : (phoneError ?? this.phoneError),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
    departmentIds,
    roleId,
    name,
    email,
    password,
    confirmPassword,
    birthdate,
    joinedAt,
    phone,
    profileImageBytes,
    profileImageName,
    profileImagePath,
    departmentError,
    roleError,
    profileImageError,
    nameError,
    emailError,
    passwordError,
    confirmPasswordError,
    birthdateError,
    joinedAtError,
    phoneError,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}
