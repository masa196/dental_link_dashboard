import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response_model.g.dart';

@JsonSerializable(createToJson: false)
class BaseResponseModel extends Equatable {
  const BaseResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.errors,
  });

  final bool? success;
  final int? status;
  final String? message;
  final dynamic errors;

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson(json);

  @override
  List<Object?> get props => [
        success,
        status,
        message,
        errors,
      ];
}