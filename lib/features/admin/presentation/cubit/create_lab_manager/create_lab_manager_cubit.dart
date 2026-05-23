import 'dart:typed_data';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/utils/app_validators.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/location/location_entity.dart';
import 'create_lab_manager_cubit_state.dart';

@injectable
class CreateLabManagerCubit extends Cubit<CreateLabManagerCubitState> {
  CreateLabManagerCubit() : super(const CreateLabManagerCubitState());

  void _updateEntity(CreateLabManagerEntity newEntity) {
    emit(state.copyWith(entity: newEntity, clearErrors: true));
  }

  void onLabNameChanged(String v) => _updateEntity(state.entity.copyWith(labName: v));
  void onManagerNameChanged(String v) => _updateEntity(state.entity.copyWith(managerName: v));
  void onEmailChanged(String v) => _updateEntity(state.entity.copyWith(email: v));
  void onPhoneChanged(String v) => _updateEntity(state.entity.copyWith(phone: v));
  void onPasswordChanged(String v) => _updateEntity(state.entity.copyWith(password: v));
  void onConfirmPasswordChanged(String v) => _updateEntity(state.entity.copyWith(passwordConfirmation: v));
  
  void onPhotoChanged(Uint8List bytes, String name) => 
      _updateEntity(state.entity.copyWith(photo: bytes, photoName: name));
      
  void onLocationChanged(LocationEntity? loc) => 
      _updateEntity(state.entity.copyWith(location: loc));

  void togglePasswordVisibility() => 
      _updateEntity(state.entity.copyWith(hidePassword: !(state.entity.hidePassword ?? true)));

  void toggleConfirmVisibility() => 
      _updateEntity(state.entity.copyWith(hideConfirm: !(state.entity.hideConfirm ?? true)));

  // تم تحديث الدالة لتستقبل كائن الترجمة لضمان ظهور الأخطاء باللغة الصحيحة
  bool validate(AppLocalizations l10n) {
    final lErr = AppValidators.validateEmpty(
      state.entity.labName, 
      l10n.fieldRequired,
    );
    
    final mErr = AppValidators.validateEmpty(
      state.entity.managerName, 
      l10n.fieldRequired,
    );
    
    final eErr = AppValidators.validateEmail(
      state.entity.email, 
      l10n.fieldRequired, 
      l10n.invalidEmail,
    );
    
    final pErr = AppValidators.validatePhone(
      state.entity.phone, 
      l10n.fieldRequired, 
      l10n.phoneOnlyDigits,
    );
    
    final passErr = AppValidators.validatePassword(
      state.entity.password, 
      l10n.fieldRequired, 
      l10n.passwordTooShort,
    );
    
    final cErr = AppValidators.validateConfirmPassword(
      state.entity.password, 
      state.entity.passwordConfirmation, 
      l10n.fieldRequired, 
      l10n.passwordsDoNotMatch,
    );

    final locErr = (state.entity.location == null || state.entity.location?.name == null || state.entity.location!.name!.isEmpty)
      ? l10n.fieldRequired 
      : null;

    emit(state.copyWith(
      labNameError: lErr,
      managerNameError: mErr,
      emailError: eErr,
      phoneError: pErr,
      passwordError: passErr,
      passwordConfirmationError: cErr,
      locationError: locErr,
    ));

    return [lErr, mErr, eErr, pErr, passErr, cErr, locErr].every((e) => e == null);
  }

  void reset() => emit(const CreateLabManagerCubitState());
}