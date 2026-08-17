import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/system_logs/system_logs_model.dart';

enum SystemLogsStatus {
  initial,
  loading,
  success,
  failure,
}

class SystemLogsState extends Equatable {
  const SystemLogsState({
    this.status = SystemLogsStatus.initial,
    this.data = const [],
    this.message,
    this.error,
    this.currentPage = 1,
    this.perPage = 15,
  });

  final SystemLogsStatus status;

  final List<SystemLogItem> data;

  /// رسالة السيرفر
  final String? message;

  /// الخطأ القادم من AppErrorMapper
  final AppFailure? error;

  final int currentPage;

  final int perPage;

  bool get isInitial => status == SystemLogsStatus.initial;

  bool get isLoading => status == SystemLogsStatus.loading;

  bool get isSuccess => status == SystemLogsStatus.success;

  bool get isFailure => status == SystemLogsStatus.failure;

  SystemLogsState copyWith({
    SystemLogsStatus? status,
    List<SystemLogItem>? data,
    String? message,
    AppFailure? error,
    int? currentPage,
    int? perPage,
    bool clearMessage = false,
    bool clearError = false,
  }) {
    return SystemLogsState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: clearMessage ? null : message ?? this.message,
      error: clearError ? null : error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        message,
        error,
        currentPage,
        perPage,
      ];
}