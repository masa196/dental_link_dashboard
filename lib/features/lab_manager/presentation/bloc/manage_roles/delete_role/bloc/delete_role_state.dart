import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:equatable/equatable.dart';

class DeleteRoleState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? message;
  final AppFailure? failure;

  const DeleteRoleState({
    this.isLoading = false,
    this.isSuccess = false,
    this.message,
    this.failure,
  });

  DeleteRoleState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? message,
    AppFailure? failure,
  }) {
    return DeleteRoleState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        message,
        failure,
      ];
}