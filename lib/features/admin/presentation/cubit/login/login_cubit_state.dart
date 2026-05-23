import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/login_entity.dart';

class LoginCubitState extends Equatable {
  const LoginCubitState({
    this.isPasswordVisible = false,
    this.entity = const LoginEntity(
      email: '',
      password: '',
    ),
    this.emailError,
    this.passwordError,
    this.rateLimitRemainingSeconds = 0,
  });

  final bool isPasswordVisible;

  final LoginEntity entity;

  final String? emailError;
  final String? passwordError;

  final int rateLimitRemainingSeconds;

  bool get isRateLimited => rateLimitRemainingSeconds > 0;

  LoginCubitState copyWith({
    bool? isPasswordVisible,
    LoginEntity? entity,
    String? emailError,
    String? passwordError,
    int? rateLimitRemainingSeconds,
    bool clearEmailError = false,
    bool clearPasswordError = false,
  }) {
    return LoginCubitState(
      isPasswordVisible:
          isPasswordVisible ?? this.isPasswordVisible,
      entity: entity ?? this.entity,
      emailError:
          clearEmailError ? null : emailError ?? this.emailError,
      passwordError: clearPasswordError
          ? null
          : passwordError ?? this.passwordError,
      rateLimitRemainingSeconds:
          rateLimitRemainingSeconds ??
              this.rateLimitRemainingSeconds,
    );
  }

  @override
  List<Object?> get props => [
        isPasswordVisible,
        entity,
        emailError,
        passwordError,
        rateLimitRemainingSeconds,
      ];
}