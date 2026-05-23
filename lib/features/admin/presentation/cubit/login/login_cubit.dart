import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'login_cubit_state.dart';

export 'login_cubit_state.dart';

@injectable
class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(const LoginCubitState());

  Timer? _rateLimitTimer;

  @override
  Future<void> close() {
    _rateLimitTimer?.cancel();
    return super.close();
  }

  void updateEmail(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(
          email: value,
        ),
        clearEmailError: true,
      ),
    );
  }

  void updatePassword(String value) {
    emit(
      state.copyWith(
        entity: state.entity.copyWith(
          password: value,
        ),
        clearPasswordError: true,
      ),
    );
  }

  bool validateInputs() {
    final email = state.entity.email.trim();

    final password = state.entity.password;

    final emailError = email.isEmpty
        ? 'This field is required'
        : !email.contains('@')
            ? 'invalid email'
            : null;

    final passwordError =
        password.isEmpty ? 'This field is required' : null;

    emit(
      state.copyWith(
        entity: state.entity.copyWith(
          email: email,
          password: password,
        ),
        emailError: emailError,
        passwordError: passwordError,
        clearEmailError: emailError == null,
        clearPasswordError: passwordError == null,
      ),
    );

    return emailError == null && passwordError == null;
  }

  void startRateLimitCountdown(int seconds) {
    _rateLimitTimer?.cancel();

    if (seconds <= 0) {
      emit(
        state.copyWith(
          rateLimitRemainingSeconds: 0,
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        rateLimitRemainingSeconds: seconds,
      ),
    );

    _rateLimitTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final remaining =
            state.rateLimitRemainingSeconds - 1;

        if (remaining <= 0) {
          timer.cancel();

          emit(
            state.copyWith(
              rateLimitRemainingSeconds: 0,
            ),
          );

          return;
        }

        emit(
          state.copyWith(
            rateLimitRemainingSeconds: remaining,
          ),
        );
      },
    );
  }

  void clearRateLimitCountdown() {
    _rateLimitTimer?.cancel();

    emit(
      state.copyWith(
        rateLimitRemainingSeconds: 0,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        isPasswordVisible:
            !state.isPasswordVisible,
      ),
    );
  }
}