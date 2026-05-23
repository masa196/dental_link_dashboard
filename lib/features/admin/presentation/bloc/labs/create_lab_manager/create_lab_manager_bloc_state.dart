import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum CreateLabManagerRemoteStatus { initial, loading, success, failure }

class CreateLabManagerBlocState extends Equatable {
  final CreateLabManagerRemoteStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  const CreateLabManagerBlocState({
    this.status = CreateLabManagerRemoteStatus.initial,
    this.responseModel,
    this.failure,
  });

  CreateLabManagerBlocState copyWith({
    CreateLabManagerRemoteStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return CreateLabManagerBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}
