import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum CreateEmployeeStatus { initial, loading, success, failure }

class CreateEmployeeBlocState extends Equatable {
  const CreateEmployeeBlocState({
    this.status = CreateEmployeeStatus.initial,
    this.responseModel,
    this.failure,
  });

  final CreateEmployeeStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  CreateEmployeeBlocState copyWith({
    CreateEmployeeStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return CreateEmployeeBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
