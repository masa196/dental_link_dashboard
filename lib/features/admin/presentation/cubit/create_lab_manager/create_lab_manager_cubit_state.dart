// features/admin/presentation/cubit/create_lab_manager_cubit_state.dart
import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';

class CreateLabManagerCubitState extends Equatable {
  final CreateLabManagerEntity entity;
  
  final String? labNameError;
  final String? managerNameError;
  final String? emailError;
  final String? phoneError;
  final String? locationError;
  final String? passwordError;
  final String? passwordConfirmationError;

  const CreateLabManagerCubitState({
    this.entity = const CreateLabManagerEntity(
      hidePassword: true,
      hideConfirm: true,
    ),
    this.labNameError,
    this.managerNameError,
    this.emailError,
    this.phoneError,
    this.locationError,
    this.passwordError,
    this.passwordConfirmationError,
  });

  CreateLabManagerCubitState copyWith({
    CreateLabManagerEntity? entity,
    String? labNameError,
    String? managerNameError,
    String? emailError,
    String? phoneError,
    String? locationError,
    String? passwordError,
    String? passwordConfirmationError,
    bool clearErrors = false,
  }) {
    return CreateLabManagerCubitState(
      entity: entity ?? this.entity,
      labNameError: clearErrors ? null : (labNameError ?? this.labNameError),
      managerNameError: clearErrors ? null : (managerNameError ?? this.managerNameError),
      emailError: clearErrors ? null : (emailError ?? this.emailError),
      phoneError: clearErrors ? null : (phoneError ?? this.phoneError),
      locationError: clearErrors ? null : (locationError ?? this.locationError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      passwordConfirmationError: clearErrors ? null : (passwordConfirmationError ?? this.passwordConfirmationError),
    );
  }

  @override
  List<Object?> get props => [
        entity,
        labNameError,
        managerNameError,
        emailError,
        phoneError,
        locationError,
        passwordError,
        passwordConfirmationError,
      ];
}