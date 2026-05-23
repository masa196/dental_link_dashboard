import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/edit_lab_manager/edit_lab_manager_entity.dart';

class EditLabManagerCubitState extends Equatable {
  final EditLabManagerEntity entity;

  final bool hidePassword;
  final bool hideConfirmPassword;
  final Uint8List? photo;
  final String? photoName;

  final String? labNameError;
  final String? managerNameError;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final String? passwordConfirmationError;
  final String? locationError;

  const EditLabManagerCubitState({
    required this.entity,
    this.hidePassword = true,
    this.hideConfirmPassword = true,
    this.photo,
    this.photoName,
    this.labNameError,
    this.managerNameError,
    this.emailError,
    this.phoneError,
    this.passwordError,
    this.passwordConfirmationError,
    this.locationError,
  });

  factory EditLabManagerCubitState.initial() {
    const initialEntity = EditLabManagerEntity(
      labId: 0,
      labName: '',
      managerName: '',
      email: '',
      phone: '',
    );

    return EditLabManagerCubitState(entity: initialEntity);
  }

  EditLabManagerCubitState copyWith({
    EditLabManagerEntity? entity,
    bool? hidePassword,
    bool? hideConfirmPassword,
    Uint8List? photo,
    String? photoName,
    String? labNameError,
    String? managerNameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    String? passwordConfirmationError,
    String? locationError,
    bool clearLabNameError = false,
    bool clearManagerNameError = false,
    bool clearEmailError = false,
    bool clearPhoneError = false,
    bool clearPasswordError = false,
    bool clearPasswordConfirmationError = false,
    bool clearLocationError = false,
  }) {
    return EditLabManagerCubitState(
      entity: entity ?? this.entity,
      hidePassword: hidePassword ?? this.hidePassword,
      hideConfirmPassword: hideConfirmPassword ?? this.hideConfirmPassword,
      photo: photo ?? this.photo,
      photoName: photoName ?? this.photoName,
      labNameError: clearLabNameError
          ? null
          : labNameError ?? this.labNameError,
      managerNameError: clearManagerNameError
          ? null
          : managerNameError ?? this.managerNameError,
      emailError: clearEmailError ? null : emailError ?? this.emailError,
      phoneError: clearPhoneError ? null : phoneError ?? this.phoneError,
      passwordError: clearPasswordError
          ? null
          : passwordError ?? this.passwordError,
      passwordConfirmationError: clearPasswordConfirmationError
          ? null
          : passwordConfirmationError ?? this.passwordConfirmationError,
      locationError: clearLocationError
          ? null
          : locationError ?? this.locationError,
    );
  }

  @override
  List<Object?> get props => [
    entity,
    hidePassword,
    hideConfirmPassword,
    photo,
    photoName,
    labNameError,
    managerNameError,
    emailError,
    phoneError,
    passwordError,
    passwordConfirmationError,
    locationError,
  ];
}
