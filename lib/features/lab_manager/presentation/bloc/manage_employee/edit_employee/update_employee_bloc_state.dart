import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum UpdateEmployeeStatus { initial, loading, success, failure }

class UpdateEmployeeBlocState extends Equatable {
  const UpdateEmployeeBlocState({
    this.status = UpdateEmployeeStatus.initial,
    this.responseModel,
    this.failure,
  });

  final UpdateEmployeeStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  UpdateEmployeeBlocState copyWith({
    UpdateEmployeeStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return UpdateEmployeeBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}