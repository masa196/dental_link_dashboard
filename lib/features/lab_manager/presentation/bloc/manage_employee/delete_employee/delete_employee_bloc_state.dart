import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum DeleteEmployeeStatus { initial, loading, success, failure }

class DeleteEmployeeBlocState extends Equatable {
  const DeleteEmployeeBlocState({
    this.status = DeleteEmployeeStatus.initial,
    this.responseModel,
    this.failure,
  });

  final DeleteEmployeeStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  DeleteEmployeeBlocState copyWith({
    DeleteEmployeeStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return DeleteEmployeeBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
