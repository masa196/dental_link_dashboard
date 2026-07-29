import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:equatable/equatable.dart';

class DeletePackageState extends Equatable {
  const DeletePackageState({
    this.isLoading = false,
    this.success = false,
    this.failure,
    this.message,
  });

  final bool isLoading;
  final bool success;
  final AppFailure? failure;
  final String? message;

  DeletePackageState copyWith({
    bool? isLoading,
    bool? success,
    AppFailure? failure,
    String? message,
    
    bool clearFailure = false,
  }) {
    return DeletePackageState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      failure: clearFailure ? null : failure ?? this.failure,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        success,
        failure,
        message
      ];
}