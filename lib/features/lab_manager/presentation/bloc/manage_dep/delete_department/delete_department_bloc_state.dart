import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum DeleteDepartmentStatus { initial, loading, success, failure }

class DeleteDepartmentBlocState extends Equatable {
  const DeleteDepartmentBlocState({
    this.status = DeleteDepartmentStatus.initial,
    this.responseModel,
    this.failure,
  });

  final DeleteDepartmentStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  DeleteDepartmentBlocState copyWith({
    DeleteDepartmentStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return DeleteDepartmentBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
