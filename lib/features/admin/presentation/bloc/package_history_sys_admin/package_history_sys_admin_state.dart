import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/package_history_sys_admin/package_history_sys_admin_model.dart';
import 'package:equatable/equatable.dart';

class PackageHistorySysAdminState extends Equatable {
  const PackageHistorySysAdminState({
    this.isLoading = false,
    this.success = false,
    this.message,
    this.failure,
    this.response,
  });

  final bool isLoading;
  final bool success;
  final String? message;
  final AppFailure? failure;
  final PackageHistoryInSysAdminResponse? response;

  PackageHistorySysAdminState copyWith({
    bool? isLoading,
    bool? success,
    String? message,
    AppFailure? failure,
    PackageHistoryInSysAdminResponse? response,
    bool clearFailure = false,
  }) {
    return PackageHistorySysAdminState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      message: message ?? this.message,
      failure: clearFailure ? null : failure ?? this.failure,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        success,
        message,
        failure,
        response,
      ];
}