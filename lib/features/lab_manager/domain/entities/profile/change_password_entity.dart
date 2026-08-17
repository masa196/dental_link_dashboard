import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  const ChangePasswordEntity({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirmation,
  });

  final String currentPassword;
  final String password;
  final String passwordConfirmation;

  @override
  List<Object?> get props => [
        currentPassword,
        password,
        passwordConfirmation,
      ];
}