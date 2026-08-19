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
    this.perPage = 5,
    this.total = 0,
    this.lastPage = 1,
  });

  final SystemLogsStatus status;

  /// سجلات النظام
  final List<SystemLogItem> data;

  /// رسالة السيرفر
  final String? message;

  /// الخطأ القادم من AppErrorMapper
  final AppFailure? error;

  /// الصفحة الحالية
  final int currentPage;

  /// عدد العناصر في الصفحة
  final int perPage;

  /// العدد الكلي للسجلات
  final int total;

  /// آخر صفحة
  final int lastPage;

  bool get isInitial => status == SystemLogsStatus.initial;

  bool get isLoading => status == SystemLogsStatus.loading;

  bool get isSuccess => status == SystemLogsStatus.success;

  bool get isFailure => status == SystemLogsStatus.failure;

  bool get hasPagination => lastPage > 1;

  SystemLogsState copyWith({
    SystemLogsStatus? status,
    List<SystemLogItem>? data,
    String? message,
    AppFailure? error,
    int? currentPage,
    int? perPage,
    int? total,
    int? lastPage,
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
      total: total ?? this.total,
      lastPage: lastPage ?? this.lastPage,
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
        total,
        lastPage,
      ];
}