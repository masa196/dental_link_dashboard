import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum UpdateDepartmentStatus { initial, loading, success, failure }

class UpdateDepartmentBlocState extends Equatable {
  const UpdateDepartmentBlocState({
    this.status = UpdateDepartmentStatus.initial,
    this.responseModel,
    this.failure,
  });

  final UpdateDepartmentStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  UpdateDepartmentBlocState copyWith({
    UpdateDepartmentStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return UpdateDepartmentBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
