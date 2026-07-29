import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:equatable/equatable.dart';

class UpdatePackageState extends Equatable {
  const UpdatePackageState({
    this.isLoading = false,
    this.success = false,
    this.message,
    this.failure,
  });

  final bool isLoading;
  final bool success;
  final String? message;
  final AppFailure? failure;

  UpdatePackageState copyWith({
    bool? isLoading,
    bool? success,
    String? message,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return UpdatePackageState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      message: message ?? this.message,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        success,
        message,
        failure,
      ];
}