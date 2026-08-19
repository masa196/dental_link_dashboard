import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/package/package_assigned_model.dart';

class GetPackageAssignedState extends Equatable {
  const GetPackageAssignedState({
    this.isLoading = false,
    this.data,
    this.failure,
  });

  final bool isLoading;
  final PackageAssignedResponse? data;
  final AppFailure? failure;

  bool get hasData => data?.data != null;

  PackageAssignedModel? get package => data?.data;

  GetPackageAssignedState copyWith({
    bool? isLoading,
    PackageAssignedResponse? data,
    AppFailure? failure,
    bool clearData = false,
    bool clearFailure = false,
  }) {
    return GetPackageAssignedState(
      isLoading: isLoading ?? this.isLoading,
      data: clearData ? null : data ?? this.data,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        data,
        failure,
      ];
}