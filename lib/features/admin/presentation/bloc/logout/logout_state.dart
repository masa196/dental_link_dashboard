import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/logout/logout_response_model.dart';

enum LogoutStatus { initial, loading, success, failure }

class LogoutState extends Equatable {
  const LogoutState({
    this.status = LogoutStatus.initial,
    this.response,
    this.failure,
  });

  final LogoutStatus status;
  final LogoutResponseModel? response;
  final AppFailure? failure;

  bool get isLoading => status == LogoutStatus.loading;
  bool get isSuccess => status == LogoutStatus.success;
  bool get isFailure => status == LogoutStatus.failure;

  LogoutState copyWith({
    LogoutStatus? status,
    LogoutResponseModel? response,
    AppFailure? failure,
  }) {
    return LogoutState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure ?? this.failure,
    );
  }

  factory LogoutState.initial() => const LogoutState();

  factory LogoutState.loading() =>
      const LogoutState(status: LogoutStatus.loading);

  factory LogoutState.success(LogoutResponseModel response) {
    return LogoutState(status: LogoutStatus.success, response: response);
  }

  factory LogoutState.failure(AppFailure failure) {
    return LogoutState(status: LogoutStatus.failure, failure: failure);
  }

  @override
  List<Object?> get props => [status, response, failure];
}
