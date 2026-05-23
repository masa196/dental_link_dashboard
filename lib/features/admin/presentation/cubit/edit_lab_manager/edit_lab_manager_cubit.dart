import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/edit_lab_manager/edit_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/location/location_entity.dart';
import 'edit_lab_manager_cubit_state.dart';

export 'edit_lab_manager_cubit_state.dart';

@injectable
class EditLabManagerCubit extends Cubit<EditLabManagerCubitState> {
  EditLabManagerCubit() : super(EditLabManagerCubitState.initial());

  void initialize(EditLabManagerEntity entity) {
    emit(state.copyWith(entity: entity));
  }

  void initializeFromLab(LabModel lab) {
    final initialLocationName = lab.address?.trim().isNotEmpty == true
        ? lab.address!.trim()
        : lab.location?.trim();

    final initialEntity = EditLabManagerEntity(
      labId: lab.id ?? 0,
      labName: lab.labName?.trim().isNotEmpty == true
          ? lab.labName!.trim()
          : lab.name?.trim() ?? '',
      managerName: lab.manager?.name?.trim() ?? '',
      email: lab.manager?.email?.trim() ?? '',
      phone: lab.phone?.trim() ?? '',
      location: initialLocationName?.isNotEmpty == true
          ? LocationEntity(
              name: initialLocationName,
              lat: lab.latitude,
              lng: lab.longitude,
            )
          : null,
    );

    emit(state.copyWith(entity: initialEntity));
  }

  void updateLabName(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(labName: value),
        clearLabNameError: true,
      ),
    );
  }

  void updateManagerName(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(managerName: value),
        clearManagerNameError: true,
      ),
    );
  }

  void updateEmail(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(email: value),
        clearEmailError: true,
      ),
    );
  }

  void updatePhone(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(phone: value),
        clearPhoneError: true,
      ),
    );
  }

  void updatePassword(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(password: value),
        clearPasswordError: true,
      ),
    );
  }

  void updatePasswordConfirmation(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(passwordConfirmation: value),
        clearPasswordConfirmationError: true,
      ),
    );
  }

  void updatePhoto(Uint8List bytes, String fileName) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(photo: bytes, photoName: fileName),
        photo: bytes,
        photoName: fileName,
      ),
    );
  }

  void updateLocation(LocationEntity location) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(location: location),
        clearLocationError: true,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(hideConfirmPassword: !state.hideConfirmPassword));
  }

  bool validateInputs() {
    String? labNameError;
    String? managerNameError;
    String? emailError;
    String? phoneError;
    String? passwordError;
    String? passwordConfirmationError;
    String? locationError;

    final entity = state.entity;

    if (entity.labName.trim().isEmpty) {
      labNameError = 'Lab name is required';
    }

    if (entity.managerName.trim().isEmpty) {
      managerNameError = 'Manager name is required';
    }

    if (entity.email.trim().isEmpty) {
      emailError = 'Email is required';
    } else if (!entity.email.contains('@')) {
      emailError = 'Invalid email format';
    }

    if (entity.phone.trim().isEmpty) {
      phoneError = 'Phone number is required';
    }

    if (entity.hasPassword) {
      if (entity.password.trim().isEmpty) {
        passwordError = 'Password is required';
      } else if (entity.password.trim().length < 6) {
        passwordError = 'Password must be at least 6 characters';
      }

      if (entity.passwordConfirmation.trim().isEmpty) {
        passwordConfirmationError = 'Password confirmation is required';
      } else if (entity.password.trim() != entity.passwordConfirmation.trim()) {
        passwordConfirmationError = 'Passwords do not match';
      }
    }

    if (entity.location == null ||
        (entity.location?.name?.trim().isEmpty ?? true)) {
      locationError = 'Address is required';
    }

    emit(
      state.copyWith(
        labNameError: labNameError,
        managerNameError: managerNameError,
        emailError: emailError,
        phoneError: phoneError,
        passwordError: passwordError,
        passwordConfirmationError: passwordConfirmationError,
        locationError: locationError,
      ),
    );

    return labNameError == null &&
        managerNameError == null &&
        emailError == null &&
        phoneError == null &&
        passwordError == null &&
        passwordConfirmationError == null &&
        locationError == null;
  }
}
