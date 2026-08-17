
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lab_statistics_model.g.dart';

@JsonSerializable(createToJson: false)
class LabStatisticsResponse extends Equatable {
   const LabStatisticsResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final LabStatistics? data;
    final dynamic errors;

    factory LabStatisticsResponse.fromJson(Map<String, dynamic> json) => _$LabStatisticsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors,];
}

@JsonSerializable(createToJson: false)
class LabStatistics extends Equatable {
  const  LabStatistics({
        required this.activeLabsCount,
        required this.inactiveLabsCount,
        required this.totalLabsCount,
    });

    @JsonKey(name: 'active_labs_count') 
    final int? activeLabsCount;

    @JsonKey(name: 'inactive_labs_count') 
    final int? inactiveLabsCount;

    @JsonKey(name: 'total_labs_count') 
    final int? totalLabsCount;

    factory LabStatistics.fromJson(Map<String, dynamic> json) => _$LabStatisticsFromJson(json);

    @override
    List<Object?> get props => [
    activeLabsCount, inactiveLabsCount, totalLabsCount, ];
}
