import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/login/login_response_model.dart';

enum LoginBlocStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginBlocStatus.initial,
    this.response,
    this.failure,
  });

  final LoginBlocStatus status;
  final LoginResponseModel? response;
  final AppFailure? failure;

  bool get isLoading => status == LoginBlocStatus.loading;
  bool get isSuccess => status == LoginBlocStatus.success;
  bool get isFailure => status == LoginBlocStatus.failure;

  LoginState copyWith({
    LoginBlocStatus? status,
    LoginResponseModel? response,
    AppFailure? failure,
  }) {
    return LoginState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure ?? this.failure,
    );
  }

  factory LoginState.initial() => const LoginState();

  factory LoginState.loading() =>
      const LoginState(status: LoginBlocStatus.loading);

  factory LoginState.success(LoginResponseModel response) {
    return LoginState(status: LoginBlocStatus.success, response: response);
  }

  factory LoginState.failure(AppFailure failure) {
    return LoginState(status: LoginBlocStatus.failure, failure: failure);
  }

  @override
  List<Object?> get props => [status, response, failure];
}
