import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

enum UpdateOrderStatusStatus {
initial,
locking,
locked,
loading,
success,
unlocking,
unlocked,
failure
}

class UpdateOrderStatusState extends Equatable {
  const UpdateOrderStatusState({
    this.status = UpdateOrderStatusStatus.initial,
    this.response,
    this.failure,
    this.orderId,
  });

  final UpdateOrderStatusStatus status;
  final BaseResponseModel? response;
  final AppFailure? failure;
  final int? orderId;

  UpdateOrderStatusState copyWith({
    UpdateOrderStatusStatus? status,
    BaseResponseModel? response,
    AppFailure? failure,
    int? orderId,
  }) {
    return UpdateOrderStatusState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        response,
        failure,
        orderId,
      ];
} 