import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum CreateDepartmentsBulkStatus { initial, loading, success, failure }

class CreateDepartmentsBulkBlocState extends Equatable {
  const CreateDepartmentsBulkBlocState({
    this.status = CreateDepartmentsBulkStatus.initial,
    this.responseModel,
    this.failure,
  });

  final CreateDepartmentsBulkStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  CreateDepartmentsBulkBlocState copyWith({
    CreateDepartmentsBulkStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return CreateDepartmentsBulkBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
