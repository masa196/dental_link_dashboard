import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';

class UpdateOrderStagesState extends Equatable {
  const UpdateOrderStagesState({
    this.isLoading = false,
    this.isSuccess = false,
    this.failure,
  });

  final bool isLoading;
  final bool isSuccess;
  final AppFailure? failure;

  UpdateOrderStagesState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return UpdateOrderStagesState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: clearFailure
          ? null
          : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        failure,
      ];
}