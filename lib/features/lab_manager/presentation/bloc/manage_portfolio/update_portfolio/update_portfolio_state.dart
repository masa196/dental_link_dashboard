import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

enum UpdatePortfolioStatus {
  initial,
  loading,
  success,
  failure,
}

class UpdatePortfolioState extends Equatable {
  const UpdatePortfolioState({
    this.status = UpdatePortfolioStatus.initial,
    this.response,
    this.failure,
  });

  final UpdatePortfolioStatus status;
  final BaseResponseModel? response;
  final AppFailure? failure;

  UpdatePortfolioState copyWith({
    UpdatePortfolioStatus? status,
    BaseResponseModel? response,
    AppFailure? failure,
  }) {
    return UpdatePortfolioState(
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