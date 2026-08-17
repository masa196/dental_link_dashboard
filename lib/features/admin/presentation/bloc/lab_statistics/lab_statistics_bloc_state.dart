import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/lab_statistics/lab_statistics_model.dart';

enum LabStatisticsStatus {
  initial,
  loading,
  success,
  failure,
}

class LabStatisticsState extends Equatable {
  const LabStatisticsState({
    this.status = LabStatisticsStatus.initial,
    this.response,
    this.failure,
  });

  final LabStatisticsStatus status;
  final LabStatisticsResponse? response;
  final AppFailure? failure;

  LabStatistics? get statistics => response?.data;

  bool get isLoading => status == LabStatisticsStatus.loading;

  bool get isSuccess => status == LabStatisticsStatus.success;

  bool get isFailure => status == LabStatisticsStatus.failure;

  LabStatisticsState copyWith({
    LabStatisticsStatus? status,
    LabStatisticsResponse? response,
    AppFailure? failure,
    bool clearResponse = false,
    bool clearFailure = false,
  }) {
    return LabStatisticsState(
      status: status ?? this.status,
      response: clearResponse ? null : response ?? this.response,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        response,
        failure,
      ];
}