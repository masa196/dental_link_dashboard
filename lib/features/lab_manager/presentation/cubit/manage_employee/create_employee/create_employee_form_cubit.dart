import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/utils/app_validators.dart';

import 'create_employee_form_state.dart';

class CreateEmployeeFormCubit extends Cubit<CreateEmployeeFormState> {
  CreateEmployeeFormCubit({List<int>? initialDepartmentIds})
    : super(
        CreateEmployeeFormState(
          departmentIds: List<int>.unmodifiable(
            initialDepartmentIds ?? const [],
          ),
        ),
      );

  void clearDepartmentError() {
    emit(state.copyWith(clearDepartmentError: true));
  }

  void updateName(String value) {
    emit(state.copyWith(name: value, clearNameError: true));
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value, clearEmailError: true));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value, clearPasswordError: true));
  }

  void updateConfirmPassword(String value) {
    emit(
      state.copyWith(confirmPassword: value, clearConfirmPasswordError: true),
    );
  }

  void updateBirthdate(String value) {
    emit(state.copyWith(birthdate: value, clearBirthdateError: true));
  }

  void updateJoinedAt(String value) {
    emit(state.copyWith(joinedAt: value, clearJoinedAtError: true));
  }

  void updatePhone(String value) {
    emit(state.copyWith(phone: value, clearPhoneError: true));
  }

  void clearRoleError() {
    emit(state.copyWith(clearRoleError: true));
  }

  void clearProfileImageError() {
    emit(state.copyWith(clearProfileImageError: true));
  }

  void clearNameError() {
    emit(state.copyWith(clearNameError: true));
  }

  void clearEmailError() {
    emit(state.copyWith(clearEmailError: true));
  }

  void clearPasswordError() {
    emit(state.copyWith(clearPasswordError: true));
  }

  void clearConfirmPasswordError() {
    emit(state.copyWith(clearConfirmPasswordError: true));
  }

  void clearBirthdateError() {
    emit(state.copyWith(clearBirthdateError: true));
  }

  void clearJoinedAtError() {
    emit(state.copyWith(clearJoinedAtError: true));
  }

  void clearPhoneError() {
    emit(state.copyWith(clearPhoneError: true));
  }

  void toggleDepartment(int departmentId) {
    final updated = List<int>.from(state.departmentIds);
    if (updated.contains(departmentId)) {
      updated.remove(departmentId);
    } else {
      updated.add(departmentId);
    }

    emit(
      state.copyWith(
        departmentIds: List<int>.unmodifiable(updated),
        clearDepartmentError: true,
      ),
    );
  }

  void setRole(int? roleId) {
    emit(state.copyWith(roleId: roleId, clearRoleError: true));
  }

  void setProfileImage({Uint8List? bytes, String? name, String? path}) {
    emit(
      state.copyWith(
        profileImageBytes: bytes,
        profileImageName: name,
        profileImagePath: path,
        clearProfileImageError: true,
      ),
    );
  }

  void clearProfileImage() {
    emit(state.copyWith(clearProfileImage: true, clearProfileImageError: true));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  bool validate({required bool isArabic}) {
    final departmentError = state.departmentIds.isEmpty
        ? (isArabic
              ? 'اختر قسمًا واحدًا على الأقل'
              : 'Select at least one department')
        : null;
    final roleError = state.roleId == null
        ? (isArabic ? 'اختر الدور' : 'Select a role')
        : null;
    final profileImageError = state.hasProfileImage
        ? null
        : (isArabic ? 'أضف صورة الموظف' : 'Add employee photo');
    final nameError = AppValidators.validateEmpty(
      state.name,
      isArabic ? 'أدخل اسم الموظف' : 'Enter employee name',
    );
    final emailError = AppValidators.validateEmail(
      state.email,
      isArabic ? 'أدخل البريد الإلكتروني' : 'Enter email address',
      isArabic ? 'البريد الإلكتروني غير صالح' : 'Invalid email address',
    );
    final passwordError = AppValidators.validatePassword(
      state.password,
      isArabic ? 'أدخل كلمة المرور' : 'Enter password',
      isArabic ? 'كلمة المرور قصيرة جدًا' : 'Password is too short',
    );
    final confirmPasswordError = AppValidators.validateConfirmPassword(
      state.password,
      state.confirmPassword,
      isArabic ? 'أدخل تأكيد كلمة المرور' : 'Confirm your password',
      isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match',
    );
    final birthdateError = AppValidators.validateMaskedDate(
      state.birthdate,
      isArabic ? 'أدخل تاريخ الميلاد' : 'Enter birthdate',
      isArabic ? 'صيغة التاريخ غير صحيحة' : 'Invalid date format',
    );
    final joinedAtError = AppValidators.validateMaskedDate(
      state.joinedAt,
      isArabic ? 'أدخل تاريخ الانضمام' : 'Enter joined date',
      isArabic ? 'صيغة التاريخ غير صحيحة' : 'Invalid date format',
    );
    final phoneError = AppValidators.validatePhone(
      state.phone,
      isArabic ? 'أدخل رقم الهاتف' : 'Enter phone number',
      isArabic ? 'يجب أن يحتوي على أرقام فقط' : 'Digits only',
    );

    emit(
      state.copyWith(
        departmentError: departmentError,
        roleError: roleError,
        profileImageError: profileImageError,
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        birthdateError: birthdateError,
        joinedAtError: joinedAtError,
        phoneError: phoneError,
      ),
    );

    return [
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
    ].every((error) => error == null);
  }
}
