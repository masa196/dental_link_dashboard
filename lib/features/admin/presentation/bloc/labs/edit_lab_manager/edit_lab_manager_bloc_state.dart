import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

enum EditLabManagerRemoteStatus { initial, loading, success, failure }

class EditLabManagerBlocState extends Equatable {
  final EditLabManagerRemoteStatus status;
  final BaseResponseModel? responseModel;
  final AppFailure? failure;

  const EditLabManagerBlocState({
    this.status = EditLabManagerRemoteStatus.initial,
    this.responseModel,
    this.failure,
  });

  EditLabManagerBlocState copyWith({
    EditLabManagerRemoteStatus? status,
    BaseResponseModel? responseModel,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return EditLabManagerBlocState(
      status: status ?? this.status,
      responseModel: responseModel ?? this.responseModel,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, responseModel, failure];
}

