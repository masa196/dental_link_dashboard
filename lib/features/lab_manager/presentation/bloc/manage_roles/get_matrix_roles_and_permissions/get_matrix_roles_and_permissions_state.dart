import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/matrix_roles_and_permissions_model.dart';

class GetMatrixRolesAndPermissionsState extends Equatable {
  const GetMatrixRolesAndPermissionsState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.response,
    this.failure,
  });

  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  final MatrixRolesResponse? response;
  final AppFailure? failure;

  GetMatrixRolesAndPermissionsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    MatrixRolesResponse? response,
    AppFailure? failure,
  }) {
    return GetMatrixRolesAndPermissionsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      response: response ?? this.response,
      failure: failure,
    );
  }

  factory GetMatrixRolesAndPermissionsState.initial() {
    return const GetMatrixRolesAndPermissionsState();
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isFailure,
        response,
        failure,
      ];
}