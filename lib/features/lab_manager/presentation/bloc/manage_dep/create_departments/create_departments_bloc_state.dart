import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum CreateDepartmentsStatus { initial, loading, success, failure }

class CreateDepartmentsBlocState extends Equatable {
  const CreateDepartmentsBlocState({
    this.status = CreateDepartmentsStatus.initial,
    this.responseModel,
    this.failure,
  });

  final CreateDepartmentsStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  CreateDepartmentsBlocState copyWith({
    CreateDepartmentsStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return CreateDepartmentsBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
