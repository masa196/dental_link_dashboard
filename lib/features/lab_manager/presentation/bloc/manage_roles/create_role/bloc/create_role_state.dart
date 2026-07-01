import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';

class CreateRoleState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? message;
  final AppFailure? failure;

  const CreateRoleState({
    this.isLoading = false,
    this.isSuccess = false,
    this.message,
    this.failure,
  });

  CreateRoleState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? message,
    AppFailure? failure,
  }) {
    return CreateRoleState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
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