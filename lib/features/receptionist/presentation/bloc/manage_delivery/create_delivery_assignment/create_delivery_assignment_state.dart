import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum CreateDeliveryAssignmentStatus {
  initial,
  loading,
  success,
  failure,
}

class CreateDeliveryAssignmentState extends Equatable {
  final CreateDeliveryAssignmentStatus status;
  final BaseResponseModel? response;
  final AppFailure? failure;

  const CreateDeliveryAssignmentState({
    this.status = CreateDeliveryAssignmentStatus.initial,
    this.response,
    this.failure,
  });

  bool get isLoading => status == CreateDeliveryAssignmentStatus.loading;
  bool get isSuccess => status == CreateDeliveryAssignmentStatus.success;
  bool get isFailure => status == CreateDeliveryAssignmentStatus.failure;

  CreateDeliveryAssignmentState copyWith({
    CreateDeliveryAssignmentStatus? status,
    BaseResponseModel? response,
    AppFailure? failure,
  }) {
    return CreateDeliveryAssignmentState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [status, response, failure];
}