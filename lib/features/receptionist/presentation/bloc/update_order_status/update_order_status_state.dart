import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

enum UpdateOrderStatusStatus {
  initial,
  loading,
  success,
  failure,
}

class UpdateOrderStatusState extends Equatable {
  const UpdateOrderStatusState({
    this.status = UpdateOrderStatusStatus.initial,
    this.response,
    this.failure,
  });

  final UpdateOrderStatusStatus status;
  final BaseResponseModel? response;
  final AppFailure? failure;

  UpdateOrderStatusState copyWith({
    UpdateOrderStatusStatus? status,
    BaseResponseModel? response,
    AppFailure? failure,
  }) {
    return UpdateOrderStatusState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        response,
        failure,
      ];
}