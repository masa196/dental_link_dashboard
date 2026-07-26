import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';


enum LabManagerProfileStatus {
  initial,
  loading,
  success,
  failure,
}


class LabManagerProfileState extends Equatable {
  const LabManagerProfileState({
    this.status = LabManagerProfileStatus.initial,
    this.response,
    this.failure,
  });


  final LabManagerProfileStatus status;
  final LabManagerProfileResponse? response;
  final AppFailure? failure;


  DataInProfile? get profile => response?.data;


  UserInProfile? get user => profile?.user;


  List<DepartmentInProfile> get departments =>
      profile?.departments ?? const [];


  bool get hasData => profile != null;


  bool get isLoading =>
      status == LabManagerProfileStatus.loading;


  bool get isSuccess =>
      status == LabManagerProfileStatus.success;


  bool get isFailure =>
      status == LabManagerProfileStatus.failure;


  bool get isInitialLoading =>
      isLoading && response == null;



  LabManagerProfileState copyWith({
    LabManagerProfileStatus? status,
    LabManagerProfileResponse? response,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return LabManagerProfileState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }


  @override
  List<Object?> get props => [
        status,
        response,
        failure,
      ];
}