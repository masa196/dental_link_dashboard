import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/all_permissions_model.dart';
import 'package:equatable/equatable.dart';

class GetAllPermissionsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final AppFailure? failure;
  final AllPermissionsResponse? response;

  const GetAllPermissionsState({
    this.isLoading = false,
    this.isSuccess = false,
    this.failure,
    this.response,
  });

  GetAllPermissionsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AppFailure? failure,
    AllPermissionsResponse? response,
  }) {
    return GetAllPermissionsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: failure,
      response: response ?? this.response,
    );
  }

  bool get isFailure => failure != null;

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        failure,
        response,
      ];
}