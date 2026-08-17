import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_assigned_model.g.dart';

@JsonSerializable(createToJson: false)
class PackageAssignedResponse extends Equatable {
   const PackageAssignedResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final PackageAssignedModel? data;
    final dynamic errors;

    factory PackageAssignedResponse.fromJson(Map<String, dynamic> json) => _$PackageAssignedResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class PackageAssignedModel extends Equatable {
  const  PackageAssignedModel({
        required this.id,
        required this.name,
        required this.description,
        required this.durationDays,
        required this.price,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? description;

    @JsonKey(name: 'duration_days') 
    final int? durationDays;
    final String? price;

    @JsonKey(name: 'is_active') 
    final bool? isActive;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    factory PackageAssignedModel.fromJson(Map<String, dynamic> json) => _$PackageAssignedModelFromJson(json);

    @override
    List<Object?> get props => [
    id, name, description, durationDays, price, isActive, createdAt, updatedAt, ];
}
