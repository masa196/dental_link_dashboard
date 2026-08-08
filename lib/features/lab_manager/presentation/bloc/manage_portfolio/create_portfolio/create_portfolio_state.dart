import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

enum CreatePortfolioStatus {
  initial,
  loading,
  success,
  failure,
}

class CreatePortfolioState extends Equatable {
  const CreatePortfolioState({
    this.status = CreatePortfolioStatus.initial,
    this.response,
    this.failure,
  });

  final CreatePortfolioStatus status;
  final BaseResponseModel? response;
  final AppFailure? failure;

  CreatePortfolioState copyWith({
    CreatePortfolioStatus? status,
    BaseResponseModel? response,
    AppFailure? failure,
  }) {
    return CreatePortfolioState(
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