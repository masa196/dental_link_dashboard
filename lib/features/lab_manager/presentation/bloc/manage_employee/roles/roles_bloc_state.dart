import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/roles/roles_model.dart';

enum RolesStatus { initial, loading, success, failure }

class RolesBlocState extends Equatable {
  const RolesBlocState({
    this.status = RolesStatus.initial,
    this.response,
    this.failure,
  });

  final RolesStatus status;
  final RolesResponse? response;
  final AppFailure? failure;

  List<Role> get roles => response?.data?.roles ?? const [];

  bool get isLoading => status == RolesStatus.loading;

  bool get isInitialLoading => isLoading && response == null;

  RolesBlocState copyWith({
    RolesStatus? status,
    RolesResponse? response,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return RolesBlocState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, response, failure];
}
