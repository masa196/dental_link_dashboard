import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class AssignPackageToLabState extends Equatable {
  const AssignPackageToLabState({
    this.isLoading = false,
    this.response,
    this.failure,
  });

  final bool isLoading;
  final BaseResponseModel? response;
  final AppFailure? failure;

  AssignPackageToLabState copyWith({
    bool? isLoading,
    BaseResponseModel? response,
    AppFailure? failure,
    bool clearFailure = false,
    bool clearResponse = false,
  }) {
    return AssignPackageToLabState(
      isLoading: isLoading ?? this.isLoading,
      response: clearResponse ? null : response ?? this.response,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        response,
        failure,
      ];
}